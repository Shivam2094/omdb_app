import 'package:clean_arch/features/movies/data/models/movie_details_model.dart';

import '../../features/movies/data/models/movie_model.dart';

class MovieUtil {

  static List<MovieModel> listOfMovies(Map<String, dynamic> json) {
    final list = json['Search'] as List;
    final List<MovieModel> listOfMovies = List();
    for (var idx = 0; idx < list.length; idx++) {
      listOfMovies.add(MovieModel(
          title: list.asMap()[idx]['Title'],
          imdbID: list.asMap()[idx]['imdbID'],
          year: list.asMap()[idx]['Year'],
          type: list.asMap()[idx]['Type'],
          poster: list.asMap()[idx]['Poster'],
          isFavorite: false));
    }
    return listOfMovies;
  }



}
