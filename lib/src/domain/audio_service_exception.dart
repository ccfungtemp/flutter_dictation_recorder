class AudioServiceException implements Exception {
  AudioServiceException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => 'AudioServiceException: $message${cause != null ? ' (cause: $cause)' : ''}';
}