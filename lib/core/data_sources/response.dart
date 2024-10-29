abstract class ApiResponse<T> {
  const ApiResponse({
    this.data,
    required this.error,
    this.message,
  });

  final T? data;
  final bool error;
  final String? message;

  static fromJson<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return fromJsonT(json);
  }
}
