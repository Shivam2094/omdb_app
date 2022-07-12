import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Movie extends Equatable {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  bool isFavorite;

  Movie( {
    @required this.title,
    @required this.year,
    @required this.imdbID,
    @required this.type,
    @required this.poster,
    this.isFavorite
  });

  void setFavorite(){
    this.isFavorite=!this.isFavorite;
  }

  @override

  List<Object> get props => [title,year,imdbID,type,poster,isFavorite];
}
