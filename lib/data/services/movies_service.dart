import 'package:desafio_tecnico_wtf/data/models/popular_movies_api_model.dart';
import 'package:result_dart/result_dart.dart';

import '../models/movie_api_model.dart';

abstract class MoviesService {
  Future<Result<PopularMoviesApiModel>> getPopularMovies();

  Future<Result<MovieApiModel>> getMovie(int id);
}
