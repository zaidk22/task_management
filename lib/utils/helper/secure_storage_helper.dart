

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
    
static Future<void> saveToken(String? token) async{
  const storage = FlutterSecureStorage();
  await storage.write(key: 'access_token', value: token);

  
}

  static Future<String?> getToken() async {
      const storage = FlutterSecureStorage();
    return await storage.read(key: 'access_token');
  }
  // Function to delete token
 static  Future<void> deleteToken() async {
     const storage = FlutterSecureStorage();
    await storage.delete(key: 'access_token');
  }

static   Future<bool> isLoggedIn() async {
       const storage = FlutterSecureStorage();
    String? storedToken = await storage.read(key: 'token');
    return storedToken != null && storedToken.isNotEmpty;
  }
}



