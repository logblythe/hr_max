class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  Map<String, dynamic> toJson() {
    return _message;
  }

  String toString() {
    return '$_prefix: $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
