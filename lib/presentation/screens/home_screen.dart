import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/cat_bloc/cat_bloc.dart';
import '../widgets/like_dislike_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _offset = 0.0;
  double _dragStart = 0.0;
  bool _wasOffline = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatBloc, CatState>(
      listener: (context, state) {
        if (state is CatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }

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
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Kototinder',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 25, 174, 23),
            elevation: 10,
            actions: [
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.favorite, color: Colors.white),
                    if (state is CatLiked || state is CatLoaded)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            (state is CatLiked
                                    ? state.likedCats.length
                                    : (state as CatLoaded).likedCats.length)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, '/liked'),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
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
                child: Center(child: _buildBody(state)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(CatState state) {
    if (state is CatLoading || state is CatInitial) {
      return const CircularProgressIndicator(color: Colors.white);
    } else if (state is CatLoaded ||
        state is CatLiked ||
        state is CatActionInProgress) {
      final cat =
          (state is CatLoaded
              ? state.cat
              : state is CatLiked
              ? state.cat
              : (state as CatActionInProgress).cat);
      final likedCats =
          (state is CatLoaded
              ? state.likedCats
              : state is CatLiked
              ? state.likedCats
              : []);

      return GestureDetector(
        onHorizontalDragStart:
            (details) => _dragStart = details.localPosition.dx,
        onHorizontalDragUpdate:
            (details) =>
                setState(() => _offset = details.localPosition.dx - _dragStart),
        onHorizontalDragEnd: (details) {
          if (_offset > 100) {
            context.read<CatBloc>().add(LikeCatEvent());
          } else if (_offset < -100) {
            context.read<CatBloc>().add(DislikeCatEvent());
          }
          setState(() => _offset = 0.0);
        },
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/detail', arguments: cat),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(_offset, 0, 0),
                child: CachedNetworkImage(
                  imageUrl: cat.imageUrl,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.error, size: 100, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                cat.breed,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Likes: ${likedCats.length}',
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LikeDislikeButton(
                    icon: Icons.thumb_down,
                    onPressed:
                        () => context.read<CatBloc>().add(DislikeCatEvent()),
                    color: Colors.red,
                  ),
                  const SizedBox(width: 20),
                  LikeDislikeButton(
                    icon: Icons.thumb_up,
                    onPressed:
                        () => context.read<CatBloc>().add(LikeCatEvent()),
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (state is CatError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<CatBloc>().add(LoadRandomCatEvent()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              'Try again',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );
    } else {
      return const Text('Unknown state', style: TextStyle(color: Colors.white));
    }
  }
}
