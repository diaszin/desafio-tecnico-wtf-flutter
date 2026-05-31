import 'package:desafio_tecnico_wtf/domain/entities/popular_movies.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedMovieSection extends StatelessWidget {
  final PopularMovies movie;

  const FeaturedMovieSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final Size platformSize = MediaQuery.of(context).size;
    final double imageHeight = platformSize.height * 0.4;
    final double width = platformSize.width;

    return Column(
      children: [
        Stack(
          alignment: .bottomLeft,
          children: [
            _HeroImage(
              imageURL: movie.backdropPathUrl,
              title: movie.title,
              height: imageHeight,
              width: width,
            ),
            _HeroTitle(title: movie.title, height: imageHeight, width: width),
          ],
        ),
        _HeroButtonGroup(width: width),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String imageURL;
  final String title;
  final double height;
  final double width;

  const _HeroImage({
    required this.imageURL,
    required this.title,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageURL,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xFF1C1D21).withValues(alpha: 1),
                ],
                stops: [0.4, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroTitle extends StatelessWidget {
  final String title;
  final double height;
  final double width;

  const _HeroTitle({
    required this.title,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(bottom: height * 0.14, left: width * 0.09),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              title,
              style: GoogleFonts.fraunces(
                fontWeight: .w600,
                color: Color(0xFFEDE8DD),
                fontSize: 24,
              ),
            ),

            Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(color: Color(0x99EDE8DD), size: 12),
              ),
              child: DefaultTextStyle(
                style: GoogleFonts.roboto(
                  fontWeight: .w400,
                  fontSize: 12,
                  color: Color(0x99EDE8DD),
                ),
                child: SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => Text('Item $index'),
                    separatorBuilder: (_, __) =>
                        const VerticalDivider(color: Color(0x66EDE8DD)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroButtonGroup extends StatelessWidget {
  final double width;

  const _HeroButtonGroup({required this.width});

  @override
  Widget build(BuildContext context) {
    double bigButtonWidth = width * 0.6;
    double secondaryButtonWidth = 57;
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Button(
          text: "Assistir agora",
          icon: Icons.play_arrow,
          iconColor: Color(0xFFEDE8DD),
          width: bigButtonWidth,
        ),
        Button(
          icon: Icons.bookmark_outline,
          iconColor: Color(0xFFEDE8DD),
          width: secondaryButtonWidth,
          type: ButtonType.secondary,
        ),
      ],
    );
  }
}
