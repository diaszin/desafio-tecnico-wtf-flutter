import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';


class PopularMoviesApiModel {
  int? page;
  List<MovieApiModel> results = [];
  int? totalPages;
  int? totalResults;

  PopularMoviesApiModel({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  PopularMoviesApiModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieApiModel>[];
      json['results'].forEach((v) {
        results.add(MovieApiModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}


