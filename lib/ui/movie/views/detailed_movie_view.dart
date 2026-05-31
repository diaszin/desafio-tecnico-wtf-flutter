import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_app_menu_widget.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedMovieView extends StatefulWidget {
  final int id;

  const DetailedMovieView({super.key, required this.id});

  @override
  State<DetailedMovieView> createState() => _DetailedMovieViewState();
}

class _DetailedMovieViewState extends State<DetailedMovieView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieViewModel>().loadMovie.execute(widget.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MovieViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MovieAppMenu(),
      backgroundColor: Color(0xFF1C1D21),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListenableBuilder(
                listenable: vm.loadMovie,
                builder: (context, data) {
                  if (vm.loadMovie.value.isRunning || vm.movie == null) {
                    return FeaturedMovieSectionShimmer();
                  }


                  final movie = vm.movie!;

                  return FeaturedMovieSection(
                    movie: movie,
                    summaryList: _getSummaryList(movie),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getSummaryList(Movie movie) {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 3,
        children: [Icon(Icons.star), Text(movie.voteAverage.toString())],
      ),
      Text(movie.releaseDate.year.toString()),
      Text(movie.genres.join(", ")),
      Text(movie.runtime.toString()),
    ];
  }
}
