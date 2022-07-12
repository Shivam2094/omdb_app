import 'package:clean_arch/core/response/status.dart';

class ApiResponse<ResultData> {

  ResponseState status ;
  ResultData data ;
  String message ;

  ApiResponse(this.status , this.data, this.message);


  ApiResponse.loading() : status = ResponseState.LOADING ;

  ApiResponse.completed(this.data) : status = ResponseState.COMPLETED ;

  ApiResponse.error(this.message) : status = ResponseState.ERROR ;


  @override
  String toString(){
    return "Status : $status \n Message : $message \n Data: $data" ;
  }


}

