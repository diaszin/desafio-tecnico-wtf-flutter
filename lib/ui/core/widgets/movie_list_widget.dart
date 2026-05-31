import 'package:desafio_tecnico_wtf/domain/entities/popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieList extends StatelessWidget {
  final String title;
  final List<PopularMovies>? moviesList;
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
    List<PopularMovies> list = moviesList!;
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
            color: Color(0xFFF5F0EA),
          ),
        ),
        _CardList(height: height, width: width, list: list),
      ],
    );
  }
}

class _CardList extends StatelessWidget {
  final List<PopularMovies> list;
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
          PopularMovies movie = list[index];
          return _MovieCard(size: cardSize, image: movie.posterPathUrl);
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Size size;
  final String image;

  const _MovieCard({super.key, required this.size, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: .cover),
        borderRadius: .circular(16),
      ),
    );
  }
}
