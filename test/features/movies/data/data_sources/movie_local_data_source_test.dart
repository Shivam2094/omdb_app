import 'dart:convert';

import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/utils/constants.dart';
import 'package:clean_arch/core/utils/movie_util.dart';
import 'package:clean_arch/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:clean_arch/features/movies/data/models/movie_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{}


void main()
{
  MovieLocalDataSourceImpl dataSourceImpl;
  MockSharedPreferences mockSharedPreferences;

  setUp((){
    mockSharedPreferences=MockSharedPreferences();
    dataSourceImpl=MovieLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('get last movie list cached',(){

    final Map<String, dynamic> cachedMap = json.decode(fixture('movie_cached.json'));

    final List<MovieModel> listOfMovies = MovieUtil.listOfMovies(cachedMap);


    test('should return last cached movie list from shared preferences when there is one in the cache',() async{
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('movie_cached.json'));
      // act
      final result = await dataSourceImpl.getCachedMoviesList();
      // assert
      verify(mockSharedPreferences.getString(Constants.CACHED_MOVIE_LIST));
      expect(result, equals(listOfMovies));

    });

    test('should throw CacheException when there is no cached movie list',() async{
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSourceImpl.getCachedMoviesList;
      // assert

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));

    });
  });

  group('cache movie list',(){
    Map<String, dynamic> jsonMap={};
    MovieModel tMovieModel1 = MovieModel(
        title: "Batman Begins",
        imdbID: "tt0372784",
        poster:
        "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
        year: "2005",
        type: "movie",
        isFavorite:false);
    MovieModel tMovieModel2 = MovieModel(
        title: "Batman v Superman: Dawn of Justice",
        imdbID: "tt2975590",
        poster:
        "https://m.media-amazon.com/images/M/MV5BYThjYzcyYzItNTVjNy00NDk0LTgwMWQtYjMwNmNlNWJhMzMyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
        year: "2016",
        type: "movie",
        isFavorite:false);
    final List<MovieModel> tListOfMovies = List();
    tListOfMovies.add(tMovieModel1);
    tListOfMovies.add(tMovieModel2);
    jsonMap.putIfAbsent('Search', () => tListOfMovies);
    test('should call shared preferences to cache movie list',(){
      // act
      dataSourceImpl.cacheMoviesList(tListOfMovies);
      // assert
      final expectedJsonString = json.encode(jsonMap);
      verify(mockSharedPreferences.setString(Constants.CACHED_MOVIE_LIST, expectedJsonString));

    });
  });


}