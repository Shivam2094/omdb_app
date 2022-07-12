import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class MovieDetailsLocalDataSource {
  /// Gets the cached [MovieDetailsModel]
  /// Throws [CacheException] if no cached data found
  Future<MovieDetailsModel> getCachedMovieDetails(MovieModel movieModel);
  Future<void> cacheMovieDetails(MovieDetailsModel movieDetails);
}

class MovieDetailsLocalDataSourceImpl implements MovieDetailsLocalDataSource {
  final SharedPreferences sharedPreferences;
  MovieDetailsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<MovieDetailsModel> getCachedMovieDetails(MovieModel movieModel) {
    //TODO: implement this method

  }

  @override
  Future<dynamic> cacheMovieDetails(MovieDetailsModel movieDetails) {
//TODO: implement cache movie details

  }
}
