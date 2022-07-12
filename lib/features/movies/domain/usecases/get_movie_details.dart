import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/movies/domain/repositories/movie_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/movie.dart';
import '../entities/movie_details.dart';

/// calls movie_details_repository methods

class GetMovieDetails implements UseCase <MovieDetails, Params>{
  final MovieDetailsRepository movieDetailsRepository;

  GetMovieDetails(this.movieDetailsRepository);

  @override
  Future<Either<Failure, MovieDetails>> call
      (Params params) async {
    return await movieDetailsRepository.getMovieDetails(params.movie);
  }
}

class Params extends Equatable{
  final Movie movie;
  Params({@required this.movie});

  @override

  List<Object> get props => [movie];
}
