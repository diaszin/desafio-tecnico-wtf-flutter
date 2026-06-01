import 'package:desafio_tecnico_wtf/data/models/genre_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/response_movies_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/production_company_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/spoken_language_api_model.dart';
import 'package:desafio_tecnico_wtf/domain/entities/genre.dart';
import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/entities/production_company.dart';
import 'package:desafio_tecnico_wtf/domain/entities/spoken_language.dart';

Movie movieFixture({
  int id = 1,
  String title = 'Inception',
  String originalTitle = 'Inception',
  String overview = 'A mind-bending thriller.',
  DateTime? releaseDate,
  int runtime = 148,
  double voteAverage = 8.8,
  int voteCount = 30000,
  double popularity = 150.0,
  int budget = 160000000,
  int revenue = 836800000,
  String status = 'Released',
  String originalLanguage = 'en',
  bool isAdult = false,
  bool hasVideo = false,
  String? posterPath = '/poster.jpg',
  String? backdropPath = '/backdrop.jpg',
  List<Genre>? genres,
  List<ProductionCompany>? production,
  List<SpokenLanguage>? languages,
}) {
  return Movie(
    id: id,
    title: title,
    originalTitle: originalTitle,
    overview: overview,
    releaseDate: releaseDate ?? DateTime(2010, 7, 16),
    runtime: runtime,
    voteAverage: voteAverage,
    voteCount: voteCount,
    popularity: popularity,
    budget: budget,
    revenue: revenue,
    status: status,
    originalLanguage: originalLanguage,
    isAdult: isAdult,
    hasVideo: hasVideo,
    posterPath: posterPath,
    backdropPath: backdropPath,
    originCountry: const ['US'],
    genres: genres ?? [const Genre(id: 28, name: 'Action')],
    production: production ??
        [
          const ProductionCompany(
            id: 1,
            name: 'Warner Bros.',
            logoPath: null,
            originCountry: 'US',
          ),
        ],
    languages: languages ??
        [
          const SpokenLanguage(
            englishName: 'English',
            iso6391: 'en',
            name: 'English',
          ),
        ],
  );
}


List<Movie> movieListFixture({int count = 3}) {
  return List.generate(
    count,
    (i) => movieFixture(id: i + 1, title: 'Movie ${i + 1}'),
  );
}


MovieApiModel movieApiModelFixture({
  int? id = 1,
  String? title = 'Inception',
  String? originalTitle = 'Inception',
  String? overview = 'A mind-bending thriller.',
  String? releaseDate = '2010-07-16',
  int? runtime = 148,
  double? voteAverage = 8.8,
  int? voteCount = 30000,
  double? popularity = 150.0,
  int? budget = 160000000,
  int? revenue = 836800000,
  String? status = 'Released',
  String? originalLanguage = 'en',
  bool? adult = false,
  bool? video = false,
  String? posterPath = '/poster.jpg',
  String? backdropPath = '/backdrop.jpg',
  List<GenreApiModel>? genres,
  List<ProductionCompanyApiModel>? productionCompanies,
  List<SpokenLanguageApiModel>? spokenLanguages,
}) {
  return MovieApiModel(
    id: id,
    title: title,
    originalTitle: originalTitle,
    overview: overview,
    releaseDate: releaseDate,
    runtime: runtime,
    voteAverage: voteAverage,
    voteCount: voteCount,
    popularity: popularity,
    budget: budget,
    revenue: revenue,
    status: status,
    originalLanguage: originalLanguage,
    adult: adult,
    video: video,
    posterPath: posterPath,
    backdropPath: backdropPath,
    originCountry: const ['US'],
    genres: genres ?? [const GenreApiModel(id: 28, name: 'Action')],
    productionCompanies: productionCompanies ??
        [
          const ProductionCompanyApiModel(
            id: 1,
            name: 'Warner Bros.',
            logoPath: null,
            originCountry: 'US',
          ),
        ],
    spokenLanguages: spokenLanguages ??
        [
          const SpokenLanguageApiModel(
            englishName: 'English',
            iso6391: 'en',
            name: 'English',
          ),
        ],
  );
}


ResponseMoviesApiModel popularMoviesApiModelFixture({int count = 2}) {
  return ResponseMoviesApiModel(
    page: 1,
    totalPages: 10,
    totalResults: count,
    results: List.generate(
      count,
      (i) => movieApiModelFixture(id: i + 1, title: 'Movie ${i + 1}'),
    ),
  );
}

Map<String, dynamic> movieJsonFixture() {
  return {
    'id': 1,
    'title': 'Inception',
    'original_title': 'Inception',
    'overview': 'A mind-bending thriller.',
    'release_date': '2010-07-16',
    'runtime': 148,
    'vote_average': 8.8,
    'vote_count': 30000,
    'popularity': 150.0,
    'budget': 160000000,
    'revenue': 836800000,
    'status': 'Released',
    'original_language': 'en',
    'adult': false,
    'video': false,
    'poster_path': '/poster.jpg',
    'backdrop_path': '/backdrop.jpg',
    'homepage': 'https://inception.com',
    'imdb_id': 'tt1375666',
    'tagline': 'Your mind is the scene of the crime.',
    'belongs_to_collection': null,
    'origin_country': ['US'],
    'genres': [
      {'id': 28, 'name': 'Action'},
      {'id': 878, 'name': 'Science Fiction'},
    ],
    'production_companies': [
      {
        'id': 1,
        'name': 'Warner Bros.',
        'logo_path': null,
        'origin_country': 'US',
      },
    ],
    'production_countries': [
      {'iso_3166_1': 'US', 'name': 'United States of America'},
    ],
    'spoken_languages': [
      {'english_name': 'English', 'iso_639_1': 'en', 'name': 'English'},
    ],
  };
}
