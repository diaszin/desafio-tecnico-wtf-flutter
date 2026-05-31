import 'package:flutter/material.dart';
import 'package:shimmer_ai/shimmer_ai.dart';

class FeaturedMovieSectionShimmer extends StatelessWidget {
  const FeaturedMovieSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size platformSize = MediaQuery.of(context).size;
    final double height = platformSize.height * 0.4;
    final double width = platformSize.width;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ).withShimmerAi(
      loading: true,
      baseColor: const Color(0xFF24262B),
      highlightColor: const Color(0xFF32353B),
    );
  }
}
