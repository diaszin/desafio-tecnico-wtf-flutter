import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_app_menu_widget.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: ListenableBuilder(
            listenable: vm.loadMovie,
            builder: (context, data) {
              if (vm.loadMovie.value.isRunning || vm.movie == null) {
                return FeaturedMovieSectionShimmer();
              }

              final movie = vm.movie!;

              return Column(
                children: [
                  FeaturedMovieSection(
                    movie: movie,
                    summaryList: _getSummaryList(movie),
                  ),
                  Container(
                    margin: .symmetric(horizontal: 34, vertical: 24),
                    child: Column(
                      spacing: 24,
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          movie.overview,
                          style: GoogleFonts.roboto(
                            fontWeight: .w400,
                            fontSize: 14,
                            color: Color(0xFFEDE8DD),
                          ),
                          textAlign: .left,
                        ),
                        _MovieInfoItem(
                          title: "Produtoras",
                          description: movie.popularity.toString(),
                        ),
                        Row(
                          spacing: 24,
                          children: [
                            _MovieInfoItem(
                              title: "Produtoras",
                              description: movie.popularity.toString(),
                            ),
                            _MovieInfoItem(
                              title: "Produtoras",
                              description: movie.popularity.toString(),
                            ),
                          ],
                        ),
                        _MovieInfoItem(
                          title: "Produtoras",
                          description: movie.popularity.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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

class _MovieInfoItem extends StatelessWidget {
  final String title;
  final String description;

  const _MovieInfoItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "$title:",
          style: GoogleFonts.roboto(
            fontWeight: .w400,
            fontSize: 14,
            color: Color(0xFFEDE8DD),
          ),
        ),
        Text(
          description,
          style: GoogleFonts.roboto(
            fontWeight: .w400,
            fontSize: 14,
            color: Color(0x99EDE8DD),
          ),
        ),
      ],
    );
  }
}
