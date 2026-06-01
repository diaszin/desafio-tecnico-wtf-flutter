import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:result_dart/result_dart.dart';


class MockMovieRepository implements MovieRepository {
  Result<List<Movie>>? getPopularMoviesResult;
  Result<Movie>? getMovieResult;

  int getPopularMoviesCallCount = 0;
  int getMovieCallCount = 0;
  int? lastRequestedMovieId;

  @override
  Future<Result<List<Movie>>> getPopularMovies() async {
    getPopularMoviesCallCount++;
    return getPopularMoviesResult ??
        Failure(Exception('getPopularMoviesResult not configured'));
  }

  @override
  Future<Result<Movie>> getMovie(int id) async {
    getMovieCallCount++;
    lastRequestedMovieId = id;
    return getMovieResult ??
        Failure(Exception('getMovieResult not configured'));
  }
}
