import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

void logInfo(String message, {String tag = 'APP'}) {
  if (kDebugMode) dev.log(message, name: tag, level: 800);
}

void logDebug(String message, {String tag = 'APP'}) {
  if (kDebugMode) dev.log(message, name: tag, level: 700);
}

void logError(String message, {Object? error, StackTrace? stackTrace, String tag = 'APP'}) {
  if (kDebugMode) dev.log(message, name: tag, level: 1000, error: error, stackTrace: stackTrace);
}
