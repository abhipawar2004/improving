import 'dart:convert';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

String apiErrorToJson(ApiError data) => json.encode(data.toJson());

class ApiError {
  final DateTime timestamp;
  final int status;
  final String error;
  final String path;

  ApiError({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.path,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        error: json["error"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "error": error,
        "path": path,
      };
}
