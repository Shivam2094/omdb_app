import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieModel extends Movie {
  MovieModel(
      {
        @required String title,
      @required String imdbID,
      @required String year,
      @required String type,
      @required String poster,
      bool isFavorite
      })
      : super(
            title: title,
            imdbID: imdbID,
            type: type,
            year: year,
            poster: poster,
            isFavorite: isFavorite
  );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json["Title"],
        imdbID: json["imdbID"],
        type: json["Type"],
        year: json["Year"],
        poster: json["Poster"],
        isFavorite : false
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imdbID': imdbID,
      'year': year,
      'type': type,
      'poster': poster,
      'isFavorite': isFavorite
    };
  }
}
