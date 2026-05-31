import 'package:desafio_tecnico_wtf/domain/entities/genre.dart';
import 'package:desafio_tecnico_wtf/domain/entities/production_company.dart';
import 'package:desafio_tecnico_wtf/domain/entities/spoken_language.dart';

class Movie {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? tagline;
  final String? posterPath;
  final String? backdropPath;
  final String? homepage;
  final String? imdbId;
  final DateTime releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final int budget;
  final int revenue;
  final String status;
  final String originalLanguage;
  final bool isAdult;
  final bool hasVideo;
  final List<String> originCountry;
  final List<Genre> genres;
  final List<ProductionCompany> production;
  final List<SpokenLanguage> languages;

  String get posterPathURL => "https://image.tmdb.org/t/p/w500$posterPath";

  String get backdropPathUrl => "https://image.tmdb.org/t/p/w500$backdropPath";

  const Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.budget,
    required this.revenue,
    required this.status,
    required this.originalLanguage,
    required this.isAdult,
    required this.hasVideo,
    required this.originCountry,
    this.tagline,
    this.posterPath,
    this.backdropPath,
    required this.production,
    this.imdbId,
    required this.genres,
    this.homepage,
    required this.languages,
  });
}
