import 'package:clean_arch/features/movies/data/models/movie_model.dart';
import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:clean_arch/features/movies/domain/entities/movie_details.dart';
import 'package:flutter/material.dart';

class MovieDetailsModel extends MovieDetails {


  MovieDetailsModel(
      {
        @required Movie movie,
        @required String rated,
        @required String releaseDate,
        @required String runTime,
        @required String genre,
        @required String director,
        @required String writer,
        @required String actors,
        @required String plot,
        @required String language,
        @required String country,
        @required String awards,
        @required List<dynamic> ratings,
        @required String metaScore,
        @required String imdbRating,
        @required String imdbVotes,
        @required String dvd,
        @required String boxOffice,
        @required String production,
        @required String website,
        @required String response,
      })
      : super(
      movie: movie,
      rated: rated,
      releaseDate: releaseDate,
      runTime: runTime,
      genre: genre,
      director: director,
    writer: writer,
    actors: actors,
    plot: plot,
    language: language,
    country: country,
    awards: awards,
    ratings: ratings,
    metaScore: metaScore,
    imdbRating: imdbRating,
    imdbVotes: imdbVotes,
    dvd: dvd,
    boxOffice: boxOffice,
    production: production,
    website: website,
    response: response
  );

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json, MovieModel model) {
    return MovieDetailsModel(
        rated: json["Rated"],
        releaseDate: json["Released"],
        runTime: json["Runtime"],
        genre: json["Genre"],
        director: json["Director"],
        writer: json['Writer'],
        actors: json['Actors'],
        plot: json['Plot'],
        language: json['Language'],
        country: json['Country'],
        awards: json['Awards'],
        ratings: json['Ratings'],
        metaScore: json['Metascore'],
        imdbRating: json['imdbRating'],
        imdbVotes: json['imdbVotes'],
        dvd: json['Dvd'],
        boxOffice: json['BoxOffice'],
        production: json['Production'],
        response: json['Response'],
        website: json['Website'],
      movie: model


    );
  }



  Map<String, dynamic> toJson() {
    return {
      'rated': rated,
      'releaseDate': releaseDate,
      'runTime': runTime,
      'genre': genre,
      'director': director,
      'writer': writer,
      'actors': actors,
      'plot': plot,
      'language': language,
      'country': country,
      'awards': awards,
      'ratings': ratings,
      'metaScore': metaScore,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'dvd': dvd,
      'boxOffice': boxOffice,
      'production': production,
      'response': response,
      'website': website,
      'movie': movie

    };
  }
}
