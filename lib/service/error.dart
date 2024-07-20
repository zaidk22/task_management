import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);

          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 403:
            throw ForbiddenRequestException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);

          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
     // case DioExceptionType.unknown:
       default: throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class ForbiddenRequestException extends DioException{
  ForbiddenRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'access to the requested resource is forbidden';
  }
}

class DataValidationRequestException extends DioException{
  DataValidationRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Missing data or parameters';
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException{
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
