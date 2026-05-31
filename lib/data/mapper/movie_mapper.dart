import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';
import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';

class MovieMapper {

  MovieMapper._();

  static Movie modelToDomain(MovieApiModel model) {
    return Movie(
      id: model.id ?? (throw ArgumentError('Movie.id não pode ser nulo')),
      title:
          model.title ?? (throw ArgumentError('Movie.title não pode ser nulo')),
      originalTitle: model.originalTitle ?? model.title ?? '',
      overview: model.overview ?? '',
      tagline: model.tagline,
      posterPath: model.posterPath,
      backdropPath: model.backdropPath,
      homepage: model.homepage,
      imdbId: model.imdbId,
      releaseDate: DateTime.parse("${model.releaseDate} 00:00:00"),
      runtime: model.runtime ?? 0,
      voteAverage: model.voteAverage ?? 0.0,
      voteCount: model.voteCount ?? 0,
      popularity: model.popularity ?? 0.0,
      budget: model.budget ?? 0,
      revenue: model.revenue ?? 0,
      status: model.status ?? '',
      originalLanguage: model.originalLanguage ?? '',
      isAdult: model.adult ?? false,
      hasVideo: model.video ?? false,
      originCountry: model.originCountry ?? [],
      genres: model.genres != null
          ? model.genres!.map((element) => element.toDomain()).toList()
          : [],
    );
  }
}
