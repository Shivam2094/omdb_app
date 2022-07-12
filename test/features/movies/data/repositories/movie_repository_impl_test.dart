import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:clean_arch/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:clean_arch/features/movies/data/models/movie_model.dart';
import 'package:clean_arch/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockLocalDataSource extends Mock implements MovieLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MovieRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });


  void runOnlineTests(Function test){
    group('device is online',(){
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test();
    });
  }

  void runOfflineTests(Function test){
    group('device is offline',(){
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test();
    });
  }


  group('get movie list', () {
    final tquery = "Batman";
    final tMovieModel = MovieModel(
        title: "Batman Begins",
        imdbID: "tt0372784",
        poster:
            "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
        year: "2005",
        type: "movie");
    final Movie tMovie = tMovieModel;

    List<MovieModel> tList = [];
    tList.add(tMovie);

    test('should check if device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repositoryImpl.getMoviesList(tquery);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runOnlineTests(() {

      test(
          'should return remote data when call to remote source data is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMoviesList(any))
            .thenAnswer((_) async => tList);

        //act
        final result = await repositoryImpl.getMoviesList(tquery);

        //assert
        verify(mockRemoteDataSource.getMoviesList(tquery));
        expect(result, equals(Right(tList)));
      });
      test(
          'should cache data locally when call to remote source data is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMoviesList(any))
            .thenAnswer((_) async => tList);

        //act
        await repositoryImpl.getMoviesList(tquery);

        //assert
        verify(mockRemoteDataSource.getMoviesList(tquery));
        verify(mockLocalDataSource.cacheMoviesList(tList));
      });

      test(
          'should return ServerException when call to remote source data is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMoviesList(any))
            .thenThrow(ServerException());

        //act
        final result = await repositoryImpl.getMoviesList(tquery);

        //assert
        verify(mockRemoteDataSource.getMoviesList(tquery));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runOfflineTests( () {

      test('should return last cached data if cached data is available',
              () async {
            // arrange
            when(mockLocalDataSource.getCachedMoviesList())
                .thenAnswer((_) async => tList);
            // act
            final result = await repositoryImpl.getMoviesList(tquery);
            // assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getCachedMoviesList());
            expect(result, equals(Right(tList)));
          });

      test('should return last CacheFailure if cached data is unavailable',
              () async {
            // arrange
            when(mockLocalDataSource.getCachedMoviesList())
                .thenThrow(CacheException());
            // act
            final result = await repositoryImpl.getMoviesList(tquery);
            // assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getCachedMoviesList());
            expect(result, equals(Left(CacheFailure())));
          });
    });
  });
}
