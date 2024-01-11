class WorkflowException implements Exception {
  final String message;

  WorkflowException({
    required this.message,
  });
}
