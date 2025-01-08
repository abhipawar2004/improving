import 'package:flutter/material.dart';

class FetchHook {
  final dynamic data;
  final bool isloading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchHook({
    required this.data,
    required this.isloading,
    required this.error,
    required this.refetch,
  });
}
