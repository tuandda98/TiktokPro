import 'failure.dart';
import 'dart:io';

Failure mapException(dynamic e) {
  if (e is Failure) return e;

  if (e is SocketException) {
    return NetworkFailure(details: e.message);
  }
  if (e.toString().contains('CERTIFICATE_VERIFY_FAILED')) {
    return CertificateFailure(details: e.toString());
  }
  if (e is HttpException) {
    return ServerFailure(details: e.message);
  }
  return UnknownFailure(e.toString());
}
