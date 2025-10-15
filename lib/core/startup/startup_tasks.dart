import 'dart:io';
import 'package:find_your_home_test/core/logging/logger.dart';
import 'package:path_provider/path_provider.dart';

Future<void> warmUpFileSystem() async {
  try {
    final tmp = await getTemporaryDirectory();
    logInfo('WarmUp: temp dir=${tmp.path}');
    final support = await getApplicationSupportDirectory();
    logInfo('WarmUp: support dir=${support.path}');
    await _ensureDirExists(tmp);
    await _ensureDirExists(support);
  } catch (e, st) {
    logError('WarmUp: failed', error: e, stackTrace: st);
  }
}

Future<void> _ensureDirExists(Directory dir) async {
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}
