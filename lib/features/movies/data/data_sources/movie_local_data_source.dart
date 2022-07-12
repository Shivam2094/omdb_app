import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/movie_util.dart';
import '../../../../features/movies/data/models/movie_model.dart';

abstract class MovieLocalDataSource {
  /// Gets the cached [MovieModel]
  /// Throws [CacheException] if no cached data found
  Future<List<MovieModel>> getCachedMoviesList();
  Future<dynamic> cacheMoviesList(List<dynamic> movieList);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;
  MovieLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<MovieModel>> getCachedMoviesList() {
    final jsonString = sharedPreferences.getString(Constants.CACHED_MOVIE_LIST);

    if (jsonString != null) {
      final Map<String, dynamic> cachedMap = json.decode(jsonString);



      final List<MovieModel> cachedListOfMovies =
          MovieUtil.listOfMovies(cachedMap);

      return Future.value(cachedListOfMovies);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<dynamic> cacheMoviesList(List<dynamic> movieList) {

    Map<String, dynamic> jsonMap={};
    jsonMap['Search']=movieList;



    return sharedPreferences.setString(Constants.CACHED_MOVIE_LIST, json.encode(jsonMap) );

  }
}
