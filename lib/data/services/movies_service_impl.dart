import 'package:desafio_tecnico_wtf/data/models/movie_api_model.dart';
import 'package:desafio_tecnico_wtf/data/models/response_movies_api_model.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'movies_service.dart';

class MoviesServiceImpl extends MoviesService {
  final Dio _apiClient;

  MoviesServiceImpl({required Dio apiClient}) : _apiClient = apiClient;

  @override
  Future<Result<ResponseMoviesApiModel>> getPopularMovies() async {
    try {
      final response = await _apiClient.get("/movie/popular");

      if (response.statusCode == 200) {
        ResponseMoviesApiModel result = ResponseMoviesApiModel.fromJson(
          response.data,
        );
        return Success(result);
      }

      return Failure(
        Exception("Não foi possível consultar os filmes mais populares"),
      );
    } on Exception catch (error) {
      return Failure(Exception(error));
    }
  }

  @override
  Future<Result<MovieApiModel>> getMovie(int id) async {
    try {
      final response = await _apiClient.get("/movie/$id");

      if (response.statusCode == 200) {
        MovieApiModel result = MovieApiModel.fromJson(response.data);

        return Success(result);
      }

      return Failure(
        Exception("Não foi possíve consultar o filme com ID: $id"),
      );
    } on Exception catch (error) {
      return Failure(Exception(error));
    }
  }

  @override
  Future<Result<ResponseMoviesApiModel>> getMostRatedMovies() async {
    try {
      final response = await _apiClient.get("/movie/top_rated");

      if (response.statusCode == 200) {
        ResponseMoviesApiModel result = ResponseMoviesApiModel.fromJson(
          response.data,
        );
        return Success(result);
      }

      return Failure(
        Exception("Não foi possível consultar os filmes mais populares"),
      );
    } on Exception catch (error) {
      return Failure(Exception(error));
    }
  }
}
