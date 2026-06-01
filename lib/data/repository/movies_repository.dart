import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/response_movies_api_model.dart';
import 'package:desafio_tecnico_wtf/data/services/movies_service.dart';
import 'package:desafio_tecnico_wtf/domain/entities/movie.dart';
import 'package:desafio_tecnico_wtf/domain/repository/movie_repository.dart';
import 'package:desafio_tecnico_wtf/mapper/movie_mapper.dart';
import 'package:result_dart/result_dart.dart';

class MoviesRepositoryHttp extends MovieRepository {
  final MoviesService _moviesService;

  MoviesRepositoryHttp({required MoviesService moviesService})
    : _moviesService = moviesService;

  @override
  Future<Result<List<Movie>>> getPopularMovies() async {
    final result = await _moviesService.getPopularMovies();

    return result.fold(
      (model) {
        if (model.results.isEmpty) {
          return Failure(Exception("Nenhum filme popular encontrado"));
        }
        final movies = model.results.map(MovieMapper.modelToDomain).toList();
        return Success(movies);
      },
      (error) => Failure(error), // propaga o erro original
    );
  }

  @override
  Future<Result<Movie>> getMovie(int id) async {
    try {
      MovieApiModel? externalResponse = await _moviesService
          .getMovie(id)
          .getOrNull();

      if (externalResponse == null) {
        return Failure(Exception("Não foi possível consultar o filme"));
      }

      Movie movie = MovieMapper.modelToDomain(externalResponse);

      return Success(movie);
    } on Exception catch (error) {
      return Failure(Exception(error));
    }
  }

  @override
  Future<Result<List<Movie>>> getMostRated() async {
    final result = await _moviesService.getMostRatedMovies();

    return result.fold(
          (model) {
        if (model.results.isEmpty) {
          return Failure(Exception("Nenhum filme popular encontrado"));
        }
        final movies = model.results.map(MovieMapper.modelToDomain).toList();
        return Success(movies);
      },
          (error) => Failure(error), // propaga o erro original
    );
  }
}
