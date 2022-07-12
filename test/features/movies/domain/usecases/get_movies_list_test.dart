import 'dart:math';

import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:clean_arch/features/movies/domain/repositories/movie_repository.dart';
import 'package:clean_arch/features/movies/domain/usecases/get_movies_list.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  GetMoviesList usecase;
  MockMovieRepository mockMovieRepository;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMoviesList(mockMovieRepository);
  });

  final tQuery = "Batman";
  final tMovie = Movie(
      title: "Batman Begins",
      imdbID: "tt0372784",
      poster: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
      year: "2005",
      type: "movie",
      isFavorite: false
  );

  List<Movie> tList = [];
  tList.add(tMovie);

  test('should get movies list from the repository', () async {
    //arrange
    when(mockMovieRepository.getMoviesList(any))
        .thenAnswer((_) async => Right(tList));
    // act
    final result = await usecase(Params(query: tQuery));
    // assert
    expect(result, Right(tList));
    verify(mockMovieRepository.getMoviesList(tQuery));
  });
}
