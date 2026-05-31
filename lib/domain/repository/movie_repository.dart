import 'package:desafio_tecnico_wtf/data/services/movies_service_impl.dart';
import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/entities/popular_movies.dart';
import 'package:result_dart/result_dart.dart';

abstract class MovieRepository {
  Future<Result<List<Movie>>> getPopularMovies();
  Future<Result<Movie>> getMovie(int id);
}
