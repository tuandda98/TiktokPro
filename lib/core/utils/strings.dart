import '../error/failure.dart';
import 'constants/error_constants.dart';


String getMessage(dynamic failure) {
  if (failure is Failure) {
    var msg = failure.message;
    if (failure.code != null) msg += ' (code: ${failure.code})';
    return msg;
  }
  return failure?.toString() ?? ErrorConstants.unknownError;
}

