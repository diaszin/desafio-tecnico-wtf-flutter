import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_app_menu_widget.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMoviesView extends StatefulWidget {
  const AllMoviesView({super.key});

  @override
  State<AllMoviesView> createState() => _AllMoviesViewState();
}

class _AllMoviesViewState extends State<AllMoviesView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AllMoviesViewModels>().loadPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AllMoviesViewModels>();

    final popularMovies = vm.popularMovies;
    final featuredMovie = vm.featuredMovie;

    List<Widget> movieSummaryList = [
      Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 3,
        children: [
          Icon(Icons.star),
          Text(featuredMovie.voteAverage.toString()),
        ],
      ),
      Text(featuredMovie.releaseDate!.year.toString()),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MovieAppMenu(),
      backgroundColor: Color(0xFF1C1D21),
      body: SafeArea(
        child: Column(
          children: [
            FeaturedMovieSection(
              movie: featuredMovie,
              summaryList: movieSummaryList,
            ),
          ],
        ),
      ),
    );
  }
}
