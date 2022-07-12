import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}


//General failures

class ServerFailure extends Failure{
  static String failureMessage(){
    return 'Failed to load data due to server error';
  }
}

class CacheFailure extends Failure{}

