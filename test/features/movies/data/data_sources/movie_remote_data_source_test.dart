import 'dart:convert';
import 'dart:io';

import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/utils/constants.dart';
import 'package:clean_arch/core/utils/movie_util.dart';
import 'package:clean_arch/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:clean_arch/features/movies/data/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:http/http.dart' as http;


class MockHttpClient extends Mock implements http.Client{}

void main()
{
  MovieRemoteDataSourceImpl movieRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient=MockHttpClient();
    movieRemoteDataSourceImpl=MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  void mockHttpClientSuccess()
  {
    when(mockHttpClient.get(any,headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(fixture('movie_api_response.json'),200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));
  }

  void mockHttpClientFailure(int statusCode)
  {
    when(mockHttpClient.get(any,headers: anyNamed('headers'))).thenAnswer((_)
    async => http.Response('Failed to load movie list due to api error.'
        ,404,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));
  }

  group('get Movie',(){
    String tQuery="Batman";
    String apiKey=Constants.API_KEY;
    var uri=Uri.parse('https://www.omdbapi.com/?s=${tQuery}&apikey=${apiKey}');

    final Map<String, dynamic> responseMap = json.decode(fixture('movie_api_response.json'));

    final List<MovieModel> listOfMovies = MovieUtil.listOfMovies(responseMap);


    test('should perform GET request on url with query being '
        'the request parameter '
        'and with application/json header',() async{
      // arrange

     mockHttpClientSuccess();
     // act
       movieRemoteDataSourceImpl.getMoviesList(tQuery);
       // assert
      verify(mockHttpClient.get(uri, headers: {'Content-Type': 'application/json',},
      ));

    });

    test('should return movie list successfully when response code is 200',() async{
      // arrange
      mockHttpClientSuccess();
      // act
      final result = await movieRemoteDataSourceImpl.getMoviesList(tQuery);
      // assert
      expect(result, equals(listOfMovies));
    });

    test('should throw ServerException when response code is 404 or other error code',() async{
      // arrange
      mockHttpClientFailure(404);
      // act
      final call=movieRemoteDataSourceImpl.getMoviesList;
      // assert
      expect(() => call(tQuery), throwsA(TypeMatcher<ServerException>()));
    });
  });
}