import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:kototinder/domain/entities/cat.dart';
import 'package:kototinder/domain/repositories/cat_repository.dart';
import 'data/cat_data_source.dart';
import 'data/cat_repository.dart';
import 'data/database/database.dart';
import 'presentation/bloc/cat_bloc/cat_bloc.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/liked_screen.dart';
import 'presentation/screens/detail_screen.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  final connectivity = Connectivity();
  getIt.registerSingleton<Connectivity>(connectivity);

  final connectivityResult = await connectivity.checkConnectivity();
  getIt.registerSingleton<bool>(
    connectivityResult != ConnectivityResult.none,
    instanceName: 'isOnline',
  );

  getIt.registerSingleton<CatDataSource>(CatDataSource());
  getIt.registerSingleton<CatRepository>(
    CatRepositoryImpl(getIt<CatDataSource>(), getIt<AppDatabase>()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => CatBloc(
                catRepository: getIt<CatRepository>(),
                connectivity: getIt<Connectivity>(),
              )..add(LoadRandomCatEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Cat Tinder',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/liked': (context) => const LikedScreen(),
          '/detail':
              (ctx) => CatDetailScreen(
                cat: ModalRoute.of(ctx)!.settings.arguments as Cat,
              ),
        },
      ),
    );
  }
}
