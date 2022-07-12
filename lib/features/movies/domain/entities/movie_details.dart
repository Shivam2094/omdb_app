import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'movie.dart';

class MovieDetails extends Equatable {
  final Movie movie;
  final String rated;
  final String releaseDate;
  final String runTime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final List<dynamic> ratings;
  final String metaScore;
  final String imdbRating;
  final String imdbVotes;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;

  MovieDetails({
    @required this.movie,
    @required this.rated,
    @required this.releaseDate,
    @required this.runTime,
    @required this.genre,
    @required this.director,
    @required this.writer,
    @required this.actors,
    @required this.plot,
    @required this.language,
    @required this.country,
    @required this.awards,
    @required this.ratings,
    @required this.metaScore,
    @required this.imdbRating,
    @required this.imdbVotes,
    @required this.dvd,
    @required this.boxOffice,
    @required this.production,
    @required this.website,
    @required this.response,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        movie,
        rated,
        releaseDate,
        runtimeType,
        genre,
        director,
        writer,
        actors,
        plot,
        language,
        country,
        awards,
        ratings,
        metaScore,
        imdbRating,
        imdbVotes,
        dvd,
        boxOffice,
        production,
        website,
        response
      ];
}
