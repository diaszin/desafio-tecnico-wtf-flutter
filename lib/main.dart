import 'package:desafio_tecnico_wtf/data/repository/movies_repository.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service_impl.dart';
import 'package:desafio_tecnico_wtf/router.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/all_movies_view.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/home_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'domain/repository/movie_repository.dart';

Future<void> main() async {
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
        Provider<MoviesService>(create: (context) => MoviesServiceImpl(apiClient: context.read()) as MoviesService),
        Provider<MovieRepository>(
          create: (context) =>
              MoviesRepositoryHttp(moviesService: context.read())
                  as MovieRepository,
        ),
        ChangeNotifierProvider(
          create: (context) => AllMoviesViewModels(
            movieRepository: context.read(),
            logger: context.read(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Cine Strem',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
