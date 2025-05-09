import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/cat.dart';
import '../bloc/cat_bloc/cat_bloc.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  String? selectedBreed;
  bool _wasOffline = false;

  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(LoadLikedCatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CatBloc, CatState>(
      listener: (context, state) {
        if (state is CatLoaded || state is CatLiked) {
          final isOnline = state.isOnline;
          if (!isOnline && !_wasOffline) {
            _wasOffline = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You are offline. Using cached data.'),
                backgroundColor: Colors.amber,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (isOnline && _wasOffline) {
            _wasOffline = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Connection restored!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          final List<LikedCat> likedCats =
              (state is CatLiked)
                  ? state.likedCats
                  : (state is CatLoaded)
                  ? state.likedCats
                  : [];

          final List<String> uniqueBreeds = _getUniqueBreeds(likedCats);

          if (selectedBreed != null &&
              selectedBreed != 'All breeds' &&
              !uniqueBreeds.contains(selectedBreed)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() => selectedBreed = null);
            });
          }

          final List<LikedCat> filteredCats = _filterCats(
            likedCats,
            selectedBreed,
          );

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Liked Cats (${filteredCats.length})',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromARGB(255, 25, 174, 23),
              elevation: 10,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 58, 183, 60),
                    Color.fromARGB(255, 164, 236, 177),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedBreed ?? 'All breeds',
                      items: [
                        const DropdownMenuItem<String>(
                          value: 'All breeds',
                          child: Text('All breeds'),
                        ),
                        ...likedCats.map<DropdownMenuItem<String>>((
                          LikedCat cat,
                        ) {
                          return DropdownMenuItem<String>(
                            value: cat.breed,
                            child: Text(cat.breed),
                          );
                        }).toSet(),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          selectedBreed = value == 'All breeds' ? null : value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Filter by breed',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: _buildCatsList(context, filteredCats)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> _getUniqueBreeds(List<LikedCat> cats) {
    final List<String> breeds = cats.map((cat) => cat.breed).toSet().toList();
    breeds.insert(0, 'All breeds');
    return breeds;
  }

  List<LikedCat> _filterCats(List<LikedCat> cats, String? breed) {
    if (breed == null || breed == 'All breeds') return cats;
    return cats.where((cat) => cat.breed == breed).toList();
  }

  Widget _buildCatsList(BuildContext context, List<LikedCat> cats) {
    if (cats.isEmpty) {
      return const Center(
        child: Text(
          'No liked cats yet',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: cats.length,
      itemBuilder: (context, index) {
        final cat = cats[index];
        return Dismissible(
          key: Key('${cat.id}_${cat.likedAt.millisecondsSinceEpoch}'),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            context.read<CatBloc>().add(RemoveLikedCatEvent(cat.id));
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: cat.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text(cat.breed),
              subtitle: Text(
                'Liked on: ${DateFormat('yyyy-MM-dd').format(cat.likedAt)}',
              ),
            ),
          ),
        );
      },
    );
  }
}
