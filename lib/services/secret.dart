import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

IOSOptions _getIOSOptions() => const IOSOptions();

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class Secret {
  static Future<Map<String, String>> readAll() async {
    Map<String, String> secret = {};

    final all = await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    for (var entry in all.entries) {
      secret[entry.key] = entry.value;
    }

    return secret;
  }

  Future<void> addNewItem(key, value) async {
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }
}
