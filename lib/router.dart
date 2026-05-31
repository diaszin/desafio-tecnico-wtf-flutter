import 'package:desafio_tecnico_wtf/ui/movie/views/all_movies_view.dart';
import 'package:desafio_tecnico_wtf/ui/movie/views/login_view.dart';
import 'package:go_router/go_router.dart';

final _routes = [
  GoRoute(path: "/", builder: (context, state) => LoginView()),
  GoRoute(path: "/home", builder: (context, state) => AllMoviesView()),
  GoRoute(path: "/movie/:movieid", builder: (context, state) => AllMoviesView())
];

final router = GoRouter(routes: _routes);
