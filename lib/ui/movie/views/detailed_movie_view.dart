import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/entities/spoken_language.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_movie_section.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/featured_skeleton_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/movie_app_menu_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:desafio_tecnico_wtf/ui/movie/view_models/movie_view_model.dart';
import 'package:desafio_tecnico_wtf/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/button_widget.dart';

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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: vm.loadMovie,
            builder: (context, data) {
              final command = vm.loadMovie.value;
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
                        "Pedimos desculpas! Não conseguimos encontrar o filme selecionado",
                        style: GoogleFonts.roboto(
                          color: AppColors.iceBlue,
                          fontWeight: .w400,
                          fontSize: 16,
                        ),
                        textAlign: .center,
                      ),
                      Button(
                        text: "Tentar novamente",
                        onPressed: () => vm.loadMovie.execute(widget.id),
                      ),
                    ],
                  ),
                );
              }

              if (command.isSuccess) {
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
                              color: AppColors.cream,
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
                                description: Formatters.formatMoney(
                                  movie.budget,
                                ),
                              ),
                              _MovieInfoItem(
                                title: "Bilheteria",
                                description: Formatters.formatMoney(
                                  movie.revenue,
                                ),
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
              }

              return SizedBox.shrink();
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
      Text(Formatters.formatMovieRunTime(movie.runtime)),
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
            color: AppColors.cream,
          ),
        ),
        Text(
          description,
          style: GoogleFonts.roboto(
            fontWeight: .w400,
            fontSize: 14,
            color: AppColors.cream.withAlpha(0x99),
          ),
        ),
      ],
    );
  }
}
