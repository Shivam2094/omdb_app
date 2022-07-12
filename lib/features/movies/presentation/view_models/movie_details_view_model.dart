import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/core/response/api_response.dart';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../data/data_sources/movie_details_local_data_source.dart';
import '../../data/data_sources/movie_details_remote_data_source.dart';

import '../../data/repositories/movie_details_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/usecases/get_movie_details.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final Movie movie;

  MovieDetailsViewModel({@required this.movie});

  MovieDetails movieDetails;

  GetMovieDetails getMovieDetailsUseCase;
  http.Client client;
  var prefs;
  bool error;

  ApiResponse<MovieDetails> movieDetailsResponse = ApiResponse.loading();

  void _setApiState(ApiResponse<MovieDetails> response) {
    movieDetailsResponse = response;

    notifyListeners();
  }

  Future<void> _fetchDetails() async {
    if (error == false) {
      var res = await getMovieDetailsUseCase(Params(movie: movie));
      if (res.isRight()) {
        movieDetails = res.getOrElse(null);
      } else if (res.isLeft()) {
        error = true;
        _setApiState(ApiResponse.error(ServerFailure.failureMessage()));
      }
    }
  }

  Future<void> fetchMovieDetails() async {
    client = http.Client();
    _setApiState(ApiResponse.loading());

    prefs = await SharedPreferences.getInstance();
    error = false;



    getMovieDetailsUseCase = GetMovieDetails(MovieDetailsRepositoryImpl(
        localDataSource:
            MovieDetailsLocalDataSourceImpl(sharedPreferences: prefs),
        remoteDataSource: MovieDetailsRemoteDataSourceImpl(client: client),
        networkInfo: NetworkInfoImpl(DataConnectionChecker())));

    await _fetchDetails();

    if (error == false) _setApiState(ApiResponse.completed(movieDetails));
  }

  void update(){
    notifyListeners();
  }


}
