import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/entities/spoken_language.dart';
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
                          description: movie.production
                              .map((element) => element.name)
                              .join(", "),
                        ),
                        Row(
                          spacing: 24,
                          children: [
                            _MovieInfoItem(
                              title: "Orçamento",
                              description: _formatMoney(movie.budget),
                            ),
                            _MovieInfoItem(
                              title: "Bilheteria",
                              description: _formatMoney(movie.revenue),
                            ),
                          ],
                        ),
                        _MovieInfoItem(
                          title: "Idiomas",
                          description: movie.languages
                              .map((element) => element.englishName)
                              .join(", "),
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
    final genres = movie.genres.map((element) => element.name).join(", ");

    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 3,
        children: [Icon(Icons.star), Text(movie.voteAverage.toString())],
      ),
      Text(movie.releaseDate.year.toString()),
      Text(genres),
      Text(_formatMovieRunTime(movie.runtime)),
    ];
  }

  String _formatMovieRunTime(int runtime) {
    Duration duration = Duration(minutes: runtime);

    String hour = duration.inHours.toString();
    String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    String formattedMovieTime = '${hour}h ${minutes}m';

    return formattedMovieTime;
  }

  String _formatMoney(num value) {
    if (value >= 1e9) {
      return 'US\$ ${(value / 1e9).toStringAsFixed(1)} bilhões';
    }

    if (value >= 1e6) {
      return 'US\$ ${(value / 1e6).toStringAsFixed(1)} milhões';
    }

    return 'US\$ ${value.toInt()}';
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
