import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_app_menu_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_list_widget.dart';
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

    context.read<AllMoviesViewModel>().loadPopularMoviesCommand.execute();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AllMoviesViewModel>();

    final popularMovies = vm.popularMovies;
    final featuredMovie = vm.featuredMovie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MovieAppMenu(),
      backgroundColor: Color(0xFF1C1D21),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              ListenableBuilder(
                listenable: vm.loadPopularMoviesCommand,
                builder: (context, _) {
                  final command = vm.loadPopularMoviesCommand.value;

                  if (command.isRunning) {
                    return FeaturedMovieSectionShimmer();
                  }

                  if (command.isSuccess) {
                    return FeaturedMovieSection(
                      movie: featuredMovie  ,
                      summaryList: _getSummaryList(featuredMovie),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
              Container(
                margin: .only(top: 48),
                padding: .only(left: 24),
                child: Column(
                  spacing: 32,
                  children: [
                    MovieList(
                      title: "Populares no momento",
                      moviesList: popularMovies,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getSummaryList(Movie? movie) {
    if (movie == null) {
      return [];
    }

    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 3,
        children: [Icon(Icons.star), Text(movie.voteAverage.toString())],
      ),
      Text(movie.releaseDate.year.toString()),
    ];
  }
}
