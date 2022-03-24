import 'package:mvvm/data/network/error_hundler.dart';

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}

class Failure {
  int code; // 200 or 400
  String message; // error or success

  Failure(this.code, this.message);
}
