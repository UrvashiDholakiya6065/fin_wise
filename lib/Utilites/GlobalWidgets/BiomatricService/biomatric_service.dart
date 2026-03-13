import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final bool authenticated = await auth.authenticate(
        localizedReason: "Fingerprint login",
        biometricOnly: true,

      );
      if(authenticated){
        await SharedPref.setBiometricEnable(true);
      }

      return authenticated;
    } catch (e) {
      return false;
    }
  }
}