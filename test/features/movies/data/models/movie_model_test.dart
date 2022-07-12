import 'dart:convert';

import 'package:clean_arch/features/movies/data/models/movie_model.dart';
import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMovieModel = MovieModel(
      title: "Batman Begins",
      imdbID: "tt0372784",
      poster:
          "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
      year: "2005",
      type: "movie",
    isFavorite:false
  );

  test('should be a subclass of Movie entity', () async {
    //assert
    expect(tMovieModel, isA<Movie>());
  });
  
  group('fromJson' ,() {
    
    test('should return a valid model from json data', () async {
      //arrange
      final Map<String, dynamic> jsonMap=json.decode(fixture('movie.json'));
     // act
      final result=MovieModel.fromJson(jsonMap);
      //assert
      expect(result, tMovieModel);

    });
    
  });

  group('toJson' ,() {

    test('should return a json map with proper movie data', () async {
       // act
      final result=tMovieModel.toJson();
      //assert
      final expectedMap={
        "title": "Batman Begins",
        "year": "2005",
        "imdbID": "tt0372784",
        "type": "movie",
        "poster": "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
        "isFavorite":false


      };
      expect(result, expectedMap);

    });

  });
}
