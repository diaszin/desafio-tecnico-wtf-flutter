import 'package:desafio_tecnico_wtf/data/models/response_movies_api_model.dart';
import 'package:result_dart/result_dart.dart';

import '../models/movie_api_model.dart';

abstract class MoviesService {
  Future<Result<ResponseMoviesApiModel>> getPopularMovies();

  Future<Result<MovieApiModel>> getMovie(int id);
  Future<Result<ResponseMoviesApiModel>> getMostRatedMovies();
}
