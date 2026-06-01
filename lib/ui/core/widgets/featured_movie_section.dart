import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedMovieSection extends StatelessWidget {
  final Movie? movie;
  final List<Widget> summaryList;

  const FeaturedMovieSection({
    super.key,
    required this.movie,
    required this.summaryList,
  });

  @override
  Widget build(BuildContext context) {
    final Size platformSize = MediaQuery.of(context).size;
    final double imageHeight = platformSize.height * 0.4;
    final double width = platformSize.width;

    if (movie == null) {
      return SizedBox();
    }


    Movie featured = movie!;


    return Column(
      children: [
        Stack(
          alignment: .bottomLeft,
          children: [
            _HeroImage(
              imageURL: featured.backdropPathUrl,
              title: featured.title,
              height: imageHeight,
              width: width,
            ),
            _HeroTitle(
              title: featured.title,
              height: imageHeight,
              width: width,
              summaryList: summaryList,
            ),
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
                  Theme.of(context).colorScheme.secondary.withValues(alpha: 1),
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
  final List<Widget> summaryList;

  const _HeroTitle({
    required this.title,
    required this.height,
    required this.width,
    required this.summaryList,
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
                color: AppColors.cream,
                fontSize: 24,
              ),
            ),

            Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(color: AppColors.cream.withAlpha(0x99), size: 12),
              ),
              child: DefaultTextStyle(
                style: GoogleFonts.roboto(
                  fontWeight: .w400,
                  fontSize: 12,
                  color: AppColors.cream.withAlpha(0x99),
                ),
                child: SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: summaryList.length,
                    itemBuilder: (context, index) => summaryList[index],
                    separatorBuilder: (_, _) =>
                        VerticalDivider(color: AppColors.cream.withAlpha(0x66)),
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
          iconColor: AppColors.cream,
          width: bigButtonWidth,
        ),
        Button(
          icon: Icons.bookmark_outline,
          iconColor: AppColors.cream,
          width: secondaryButtonWidth,
          type: ButtonType.secondary,
        ),
      ],
    );
  }
}
