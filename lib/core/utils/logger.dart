void logError(dynamic error, [StackTrace? stackTrace]) {
  // Print error type and message
  print('Error: ${error.runtimeType}: $error');
  // Print stack trace if provided
  if (stackTrace != null) {
    print('StackTrace: $stackTrace');
  }
}