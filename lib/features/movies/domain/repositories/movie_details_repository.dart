
import 'package:clean_arch/features/movies/domain/entities/movie_details.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie.dart';


/// Repository contract
abstract class MovieDetailsRepository{
  Future<Either<Failure, MovieDetails>>
  getMovieDetails(Movie movie);


}