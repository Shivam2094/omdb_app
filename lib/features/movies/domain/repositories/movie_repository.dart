import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';


/// Repository contract
abstract class MovieRepository{
  Future<Either<Failure, List<Movie>>>getMoviesList(String query);
  Future<Either<Failure, dynamic>>cacheMoviesList(List<dynamic> list);


}