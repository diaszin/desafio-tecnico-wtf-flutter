import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMoviesView extends StatefulWidget {
  const AllMoviesView({super.key});

  @override
  State<AllMoviesView> createState() => _AllMoviesView();
}

class _AllMoviesView extends State<AllMoviesView> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      Future.microtask(
        () => {context.read<AllMoviesViewModels>().loadPopularMovies()},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AllMoviesViewModels>();
    vm.loadPopularMovies();

    final popularMovies = context.watch<AllMoviesViewModels>().popularMovies;

    return ListView.separated(
      itemCount: popularMovies.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (ctx, i) {
        final u = popularMovies[i];
        return ListTile(
          leading: CircleAvatar(child: Text(u.title[0])),
          title: Text(u.title),
          subtitle: Text(u.originalLanguage),
        );
      },
    );
  }
}
