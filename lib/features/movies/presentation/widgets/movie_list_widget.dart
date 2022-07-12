import 'package:clean_arch/features/movies/presentation/widgets/movie_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/movie.dart';
import '../view_models/movie_list_view_model.dart';
import 'movie_card_widget.dart';

class MovieListWidget extends StatelessWidget {

  List<Movie> movies;
  final MovieListViewModel viewModel;

  MovieListWidget({this.movies, this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.movies.length,
      itemBuilder: (BuildContext context, int index) {

        final movie = this.movies[index];
        return MovieCardWidget(movie: movie,
            listViewModel: viewModel,
            callback:(movie)=>viewModel.setMovieAsFavorite(movie));

        // return
        //   ListTile(
        //   title: Text(movie.title),
        // );
      },
    );
  }

}