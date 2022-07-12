import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';
import '../../../../features/movies/data/models/movie_model.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/movie_util.dart';

abstract class MovieRemoteDataSource {
  /// Calls https://www.omdbapi.com/?s=Batman&apikey=(Your API key) endpoint
  /// Calls https://www.omdbapi.com/?s=StarWars&apikey=(Your API key)
  /// Calls https://www.omdbapi.com/?s=Matrix&apikey=(Your API key)
  /// Calls https://www.omdbapi.com/?s=indiana&apikey=(Your API key)
  /// Throws [ServerException] for all error codes.
  Future<List<MovieModel>> getMoviesList(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  MovieRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<MovieModel>> getMoviesList(String query) async {
    String apiKey = Constants.API_KEY;
    String baseUrl=Constants.BASE_URL;
    var uri = Uri.parse('${baseUrl}?s=${query}&apikey=${apiKey}');
    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {

        final Map<String, dynamic> responseMap = json.decode(response.body);



        final List<MovieModel> listOfMovies =
            MovieUtil.listOfMovies(responseMap);

        return listOfMovies;
      } else {
        throw ServerException();
      }
    } catch (exception) {
      throw ServerException();
    }
  }
}
