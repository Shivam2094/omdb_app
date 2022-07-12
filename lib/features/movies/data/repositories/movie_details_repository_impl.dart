import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../data_sources/movie_details_local_data_source.dart';
import '../data_sources/movie_details_remote_data_source.dart';



class MovieDetailsRepositoryImpl implements MovieDetailsRepository{

  final MovieDetailsRemoteDataSource remoteDataSource;
  final MovieDetailsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieDetailsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo});


  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(Movie movie) async{
    if(await networkInfo.isConnected){
      try{
        final remoteMovieDetails=await remoteDataSource.getMovieDetails(movie);
        // localDataSource.cacheMoviesList(remoteMoviesList);
        return Right(remoteMovieDetails);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(ServerFailure());

    }


  }



}