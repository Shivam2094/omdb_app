import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/core/response/api_response.dart';

import 'package:clean_arch/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:clean_arch/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:clean_arch/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:clean_arch/features/movies/domain/usecases/get_movies_list.dart';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';

import '../../domain/entities/movie.dart';

class MovieListViewModel extends ChangeNotifier {
  List<Movie> movies;
  List<Movie> favoriteMovies;
  GetMoviesList getMoviesListUseCase;
  http.Client client;
  var prefs;
  bool error;
  var queryList;

  ApiResponse<List<Movie>> movieListResponse = ApiResponse.loading();

  void _setApiState(ApiResponse<List<Movie>> response) {
    movieListResponse = response;

    notifyListeners();
  }

  Future<void> _fetchQueryResult(String query) async {
    if (error == false) {
      var res = await getMoviesListUseCase(Params(query: query));
      if (res.isRight()) {
        List<Movie> newList = new List.from(movies)
          ..addAll(res.getOrElse(null));
        movies = newList;
      } else if (res.isLeft()) {
        error = true;
        _setApiState(ApiResponse.error(ServerFailure.failureMessage()));
      }
    }
  }

  Future<void> fetchAllMovies() async {
    client = http.Client();
    movies = [];
    favoriteMovies=[];
    prefs = await SharedPreferences.getInstance();
    error = false;
    queryList = ['Batman', 'StarWars', 'Matrix', 'indiana'];
    _setApiState(ApiResponse.loading());

    getMoviesListUseCase = GetMoviesList(MovieRepositoryImpl(
        localDataSource: MovieLocalDataSourceImpl(sharedPreferences: prefs),
        remoteDataSource: MovieRemoteDataSourceImpl(client: client),
        networkInfo: NetworkInfoImpl(DataConnectionChecker())));

    for (int i = 0; i < queryList.length; i++) {
      if (error == false) {
        await _fetchQueryResult(queryList[i]);
      }
    }

    if (error == false)
      {
        _setApiState(ApiResponse.completed(movies));


      }
  }

  void setMovieAsFavorite(Movie movie)
  {
    movie.setFavorite();
    if(movie.isFavorite)
      {
        favoriteMovies.add(movie);
      }
    else{
      favoriteMovies.remove(movie);
    }

    notifyListeners();
  }

  void cacheMovieList()
  {
    try{

      getMoviesListUseCase.movieRepository.cacheMoviesList(favoriteMovies);
    }on CacheFailure{
      return;
    }

  }



}
