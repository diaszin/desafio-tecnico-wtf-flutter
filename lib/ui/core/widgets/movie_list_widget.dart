import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieList extends StatelessWidget {
  final String title;
  final List<Movie>? moviesList;
  final double height;

  const MovieList({
    super.key,
    required this.title,
    this.moviesList,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (moviesList == null) {
      return SizedBox.shrink();
    }
    List<Movie> list = moviesList!;
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontWeight: .w600,
            fontSize: 16,
            color: AppColors.beige,
          ),
        ),
        _CardList(height: height, width: width, list: list),
      ],
    );
  }
}

class _CardList extends StatelessWidget {
  final List<Movie> list;
  final double height;
  final double width;

  const _CardList({
    super.key,
    required this.height,
    required this.width,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    Size cardSize = Size(width * 0.3, height);

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          Movie movie = list[index];
          return _MovieCard(
            size: cardSize,
            image: movie.posterPathURL,
            id: movie.id,
          );
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Size size;
  final String image;
  final int id;

  const _MovieCard({
    super.key,
    required this.size,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/movie/$id");
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: .cover),
          borderRadius: .circular(16),
        ),
      ),
    );
  }
}
