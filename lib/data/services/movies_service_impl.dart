import 'package:desafio_tecnico_wtf/data/models/popular_movies_api_model.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'movies_service.dart';

class MoviesServiceImpl extends MoviesService{
  final Dio _apiClient;

  MoviesServiceImpl({required Dio apiClient}) : _apiClient = apiClient;

  @override
  Future<Result<PopularMoviesApiModel>> getPopularMovies() async{
    final response = await _apiClient.get("/movie/popular");

    if(response.statusCode == 200){
      PopularMoviesApiModel result = PopularMoviesApiModel.fromJson(response.data);
      return Success(result);
    }


    
    return Failure(Exception("Não foi possível consultar os filmes mais populares"));
  }
}
