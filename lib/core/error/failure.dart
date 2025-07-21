import '../utils/constants/error_constants.dart';

abstract class Failure {
  final String message;
  final int? code;
  final dynamic details;

  const Failure(this.message, {this.code, this.details});

  Failure copyWith({String? message, int? code, dynamic details});

  @override
  String toString() {
    var base = message;
    if (code != null) base += ' (code: $code)';
    if (details != null) base += ' - $details';
    return base;
  }
}
class NetworkFailure extends Failure {
  const NetworkFailure({String message = ErrorConstants.networkError, int? code, dynamic details})
      : super(
    message,
    code: (code == null && message == ErrorConstants.networkError) ? 1001 : code,
    details: details,
  );

  @override
  NetworkFailure copyWith({String? message, int? code, dynamic details}) =>
      NetworkFailure(
        message: message ?? this.message,
        code: code ?? this.code,
        details: details ?? this.details,
      );
}

class CertificateFailure extends Failure {
  const CertificateFailure({String message = ErrorConstants.invalidCredentials, int? code, dynamic details})
      : super(
    message,
    code: (code == null && message == ErrorConstants.invalidCredentials) ? 1002 : code,
    details: details,
  );

  @override
  CertificateFailure copyWith({String? message, int? code, dynamic details}) =>
      CertificateFailure(
        message: message ?? this.message,
        code: code ?? this.code,
        details: details ?? this.details,
      );
}

class ServerFailure extends Failure {
  const ServerFailure({String message = ErrorConstants.serverError, int? code, dynamic details})
      : super(
    message,
    code: (code == null && message == ErrorConstants.serverError) ? 1003 : code,
    details: details,
  );

  @override
  ServerFailure copyWith({String? message, int? code, dynamic details}) =>
      ServerFailure(
        message: message ?? this.message,
        code: code ?? this.code,
        details: details ?? this.details,
      );
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = ErrorConstants.unknownError, int? code, dynamic details])
      : super(
    code: (code == null && message == ErrorConstants.unknownError) ? 1004 : code,
    details: details,
  );

  @override
  UnknownFailure copyWith({String? message, int? code, dynamic details}) =>
      UnknownFailure(
        message ?? this.message,
        code ?? this.code,
        details ?? this.details,
      );
}

class APIFailure extends Failure {
  const APIFailure([super.message = ErrorConstants.apiError, int? code, dynamic details])
      : super(
    code: (code == null && message == ErrorConstants.apiError) ? 1004 : code,
    details: details,
  );

  @override
  APIFailure copyWith({String? message, int? code, dynamic details}) =>
      APIFailure(
        message ?? this.message,
        code ?? this.code,
        details ?? this.details,
      );
}