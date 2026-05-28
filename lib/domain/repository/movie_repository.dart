import 'package:desafio_tecnico_wtf/data/services/movies_service.dart';
import 'package:desafio_tecnico_wtf/domain/models/popular_movies.dart';
import 'package:result_dart/result_dart.dart';

abstract class MovieRepository {
  Future<Result<List<PopularMovies>>> getPopularMovies();
}
