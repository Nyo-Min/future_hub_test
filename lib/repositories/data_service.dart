import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //Delete a string in secure storage
  deleteSecureData(String key) async {
    await secureStorage.delete(
      key: key,
    );
  }

  //Store a string in secure storage
  Future<bool> addSecureData(String key, String value) async {
    try {
      // if (await secureStorage.read(key: key) == null) {
        await secureStorage.write(
          key: key,
          value: value,
        );
        return true;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  // Returns the requested value by key from secure storage
  Future<String?> getSecureData(String key) async {
    try {
      return await secureStorage.read(
        key: key,
      );
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

}


