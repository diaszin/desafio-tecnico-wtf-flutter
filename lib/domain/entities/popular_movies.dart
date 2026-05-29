class PopularMovies {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String title;
  String originalLanguage;
  String originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  bool? softcore;
  bool? video;
  double? voteAverage;
  int? voteCount;

  PopularMovies({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
}
