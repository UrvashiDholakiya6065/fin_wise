import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/SessionManage/session_keys.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/FirebaseInstanceClass/firebase_instance_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> userIdAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SessionKeys.userIdToken, token);
    print("Set userIdAccessToken in pref ::::---${ prefs.getString(SessionKeys.userIdToken) }");
  }

  static Future<String?> getUserIdAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SessionKeys.userIdToken);
  }
  static Future<void> setOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SessionKeys.onboarding, value);
    print("Set onboarding in pref ::::---${ prefs.getBool(SessionKeys.onboarding) }");
  }

  static Future<bool?> getOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SessionKeys.onboarding);
  }

  static Future<void> setBiometricEnable(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SessionKeys.biometricEnable, enable);
    print("Set Biometric Enable in pref ::::---${ prefs.getBool(SessionKeys.biometricEnable) }");
  }

  static Future<bool> getBiometricEnable() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SessionKeys.biometricEnable) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SessionKeys.userIdToken);
    print("User token remove ${SessionKeys.userIdToken}");

    await prefs.remove(SessionKeys.biometricEnable);
    print("Biometric remove ${SessionKeys.biometricEnable}");

    await FirebaseInstanceClass.auth.signOut();

    appRoute.go(AppRoutePath.loginScreen.path);
  }
  static Future<void> setFromSplash(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SessionKeys.fromSplash, value);
  }

  static Future<bool> getFromSplash() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SessionKeys.fromSplash) ?? false;
  }
  static Future<void> setFingerprintSkipped(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SessionKeys.fingerprintSkipped, value);
  }

  static Future<bool> getFingerprintSkipped() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SessionKeys.fingerprintSkipped) ?? false;
  }
  static Future<void> setUserUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SessionKeys.uid, uid);
    print("Set UserUid in pref ::::---${ prefs.getString(SessionKeys.uid) }");
  }

  static Future<String?> getUserUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SessionKeys.uid);
  }
}