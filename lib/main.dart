import 'package:desafio_tecnico_wtf/data/repository/movies_repository.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service_impl.dart';
import 'package:desafio_tecnico_wtf/router.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/movie_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'domain/repository/movie_repository.dart';
import 'ui/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger logger = Logger(
    filter: null,
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    output: null,
  );

  await dotenv.load();
  String? apiToken = dotenv.maybeGet("TMDB_API_KEY");
  String? baseURL = dotenv.maybeGet("TMDB_BASE_URL");

  if (apiToken == null || apiToken.isEmpty) {
    logger.e("A chave da API não foi localizada");
  }

  if (baseURL == null || baseURL.isEmpty) {
    logger.w("Não foi encontrado nenhuma BASE URL, utilizando url padrão ....");
  }

  runApp(
    MultiProvider(
      providers: [
        Provider<Dio>(
          create: (_) => Dio(
            BaseOptions(
              baseUrl: baseURL ?? "https://api.themoviedb.org/3",
              headers: {"Authorization": "Bearer $apiToken"},
            ),
          ),
        ),
        Provider<Logger>(create: (_) => logger),
        Provider<MoviesService>(
          create: (context) => MoviesServiceImpl(apiClient: context.read()),
        ),
        Provider<MovieRepository>(
          create: (context) =>
              MoviesRepositoryHttp(moviesService: context.read())
                  as MovieRepository,
        ),
        ChangeNotifierProvider(
          create: (context) => AllMoviesViewModel(
            movieRepository: context.read<MovieRepository>(),
            logger: context.read<Logger>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieViewModel(
            movieRepository: context.read<MovieRepository>(),
            logger: context.read<Logger>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Cine Strem',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
