// for throwing exception with user friendly message
class AppException implements Exception {
  final String errorMessage;
  const AppException(this.errorMessage);
}
