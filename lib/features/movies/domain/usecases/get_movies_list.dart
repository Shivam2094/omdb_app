import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:clean_arch/features/movies/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// calls movie_repository methods

class GetMoviesList implements UseCase <List<Movie>, Params>{
  final MovieRepository movieRepository;

  GetMoviesList(this.movieRepository);

@override
  Future<Either<Failure, List<Movie>>> call
    (Params params) async {
    return await movieRepository.getMoviesList(params.query);
  }
}

class Params extends Equatable{
  final String query;
  Params({@required this.query});

  @override

  List<Object> get props => [query];
}
