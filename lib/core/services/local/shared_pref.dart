import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;
  static const String ktoken = "token";
  static const String kUserData = "kuserdata";
  static const String kImage = "kimage";
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static SharedPref get instance => SharedPref();
  //set token
  static setToken(String? token) {
    if (token == null) return;
    setData(ktoken, token);
  }

  //get token
  static String? getToken() {
    return getData(ktoken);
  }

  // set userdata after convert object ==> json == string
  static setUserCache(AuthUSer? user) {
    if (user == null) return;
    var obToJson = user.toJson();

    String userString = jsonEncode(obToJson);
    setData(kUserData, userString);
  }

  //set image and convert  to String
  static Future<void> setImage(
    Uint8List? imageBytes, {
    String key = kImage,
  }) async {
    if (imageBytes == null) return;
    final base64Str = base64Encode(imageBytes);
    await prefs.setString(key, base64Str);
  }

  // get image==> convert to Image
  static Image? getImage({
    String key = kImage,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
  }) {
    final base64Str = prefs.getString(key);
    if (base64Str == null) return null;

    final bytes = base64Decode(base64Str);
    return Image.memory(bytes, height: height, width: width, fit: fit);
  }

  // get userDate after conver string ==> json ==> object

  static getUserData() {
    String? userString = getData(kUserData);
    if (userString == null) return;

    var stToJson = jsonDecode(userString);
    return AuthUSer.fromJson(stToJson);
  }

  //default setData
  static setData(String key, dynamic value) {
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
  }

  //default getData
  static getData(String key) {
    return prefs.get(key);
  }

  //default delete
  static detete(String key) {
    return prefs.remove(key);
  }
}
