import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:clean_arch/features/movies/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/network/network_info.dart';

import '../data_sources/movie_local_data_source.dart';


class MovieRepositoryImpl implements MovieRepository{

  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    @required this.remoteDataSource,
     @required this.localDataSource,
     @required this.networkInfo});


  @override
  Future<Either<Failure, List<Movie>>> getMoviesList(String query) async{
    if(await networkInfo.isConnected){
      try{
        final remoteMoviesList=await remoteDataSource.getMoviesList(query);

        return Right(remoteMoviesList);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(ServerFailure());


    }


  }

  @override
  Future<Either<Failure, dynamic>> cacheMoviesList(List<dynamic> list) async {
    try{
      await localDataSource.cacheMoviesList(list);

    }on CacheException {
      return Left(CacheFailure());
    }

  }




  
}