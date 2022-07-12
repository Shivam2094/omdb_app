import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/features/movies/data/models/movie_model.dart';


import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/utils/constants.dart';

import '../models/movie_details_model.dart';

abstract class MovieDetailsRemoteDataSource {

  /// Calls http://www.omdbapi.com/?i=(IMDb ID)&apikey=(Your API Key)
  /// Throws [ServerException] for all error codes.
  Future<MovieDetailsModel> getMovieDetails(MovieModel movieModel);
}

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final http.Client client;
  MovieDetailsRemoteDataSourceImpl({@required this.client});

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieModel movieModel) async {
    String apiKey = Constants.API_KEY;
    String baseUrl=Constants.BASE_URL;



    var uri = Uri.parse('${baseUrl}?i=${movieModel.imdbID}&apikey=${apiKey}');
    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {

        final Map<String, dynamic> responseMap = json.decode(response.body);



        final MovieDetailsModel movieDetails=MovieDetailsModel.fromJson(responseMap,movieModel);

        return movieDetails;
      } else {
        throw ServerException();
      }
    } catch (exception) {
      throw ServerException();
    }
  }
}
