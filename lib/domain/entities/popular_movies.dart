class PopularMovies {
  bool? adult;
  String backdropPath;
  List<int>? genreIds;
  int? id;
  String title;
  String originalLanguage;
  String originalTitle;
  String? overview;
  double? popularity;
  String posterPath;
  String? releaseDate;
  bool? softcore;
  bool? video;
  double? voteAverage;
  int? voteCount;

  String get posterPathUrl =>  "https://image.tmdb.org/t/p/w500$posterPath";

  String get backdropPathUrl => "https://image.tmdb.org/t/p/w500$backdropPath";

  PopularMovies({
    this.adult,
    required this.backdropPath,
    this.genreIds,
    this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    this.popularity,
    required this.posterPath,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
}
