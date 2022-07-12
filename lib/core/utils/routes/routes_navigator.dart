import 'package:clean_arch/features/movies/presentation/views/movies_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch/core/utils/routes/routes_name.dart';

import '../../../features/movies/domain/entities/movie.dart';
import '../../../features/movies/presentation/view_models/movie_list_view_model.dart';
import '../../../features/movies/presentation/views/movie_details_screen.dart';

class RoutesNavigator {

static Movie movie;
static MovieListViewModel listViewModel;



  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.movie_list_screen:
        return MaterialPageRoute(builder: (BuildContext context) => MoviesListScreen());
        break;
      case RoutesName.movie_details_screen:
        return MaterialPageRoute(builder: (BuildContext context) => MovieDetailsScreen(movie: movie,listViewModel: listViewModel,));
        break;



      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}