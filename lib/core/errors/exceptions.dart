abstract class AppException implements Exception {
  const AppException(this.message);
  final String message;
  @override
  String toString() => '$runtimeType: $message';
}

class ConfigurationException extends AppException {
  const ConfigurationException(super.message);
}

class LLMClientError extends AppException {
  const LLMClientError(super.message);
}
