import 'package:desafio_tecnico_wtf/ui/movie/views/all_movies_view.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/detailed_movie_view.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _routes = [
  GoRoute(path: "/", builder: (context, state) => LoginView()),
  GoRoute(path: "/home", builder: (context, state) => AllMoviesView()),
  GoRoute(
    path: "/movie/:movieid",
    builder: (context, state) {
      final id = int.parse(state.pathParameters["movieid"]!);

      return DetailedMovieView(key: ValueKey(id), id: id);
    },
  ),
];

final router = GoRouter(routes: _routes);
