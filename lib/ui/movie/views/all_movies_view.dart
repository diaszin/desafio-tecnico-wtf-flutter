import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/button_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_app_menu_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_list_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/all_movies_view_models.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    context.read<AllMoviesViewModel>().loadMostRatedMoviesCommand.execute();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AllMoviesViewModel>();

    final popularMovies = vm.popularMovies;
    final featuredMovie = vm.featuredMovie;
    final mostRatedMovies = vm.mostRatedMovies;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MovieAppMenu(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: Listenable.merge([vm.loadPopularMoviesCommand, vm.loadMostRatedMoviesCommand]),
            builder: (context, _) {
              final command = vm.loadPopularMoviesCommand.value;

              if (command.isRunning) {
                return FeaturedMovieSectionShimmer();
              }

              if (command.isFailure) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    spacing: 10,
                    children: [
                      Text(
                        "Ops! Não conseguimos consultar os filmes",
                        style: GoogleFonts.roboto(
                          color: AppColors.iceBlue,
                          fontWeight: .w400,
                          fontSize: 16,
                        ),
                      ),
                      Button(
                        text: "Tentar novamente",
                        onPressed: () {
                          vm.loadPopularMoviesCommand.execute();
                          vm.loadMostRatedMoviesCommand.execute();
                        },
                      ),
                    ],
                  ),
                );
              }

              if (command.isSuccess) {
                return Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  children: [
                    FeaturedMovieSection(
                      movie: featuredMovie,
                      summaryList: _getSummaryList(featuredMovie),
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
                          MovieList(
                            title: "Bem avaliados",
                            moviesList: mostRatedMovies,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return SizedBox.shrink();
            },
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
