import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {
  static final auth = LocalAuthentication();

  static availableBiometrics() async {
    final availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {}

    if (availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {}
  }

  static Future<bool> canCheckBiometrics() async => auth.canCheckBiometrics;

  static Future<(bool, String)> authenticate({bool biometricOnly = false}) async {
    try {
      final bool didAuth = await auth.authenticate(
          localizedReason: 'Autenticate para continuar',
          options: AuthenticationOptions(biometricOnly: biometricOnly // si esta en 'false' podemos colocar el PIN
              ));

      return (didAuth, didAuth ? 'Desbloqueado' : 'Cancelado por usuario');
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) return (false, 'No hay biométricos enrolados');
      if (e.code == auth_error.lockedOut) return (false, 'Muchos intentos fallidos');
      if (e.code == auth_error.notAvailable) return (false, 'No hay biométricos disponibles');
      if (e.code == auth_error.passcodeNotSet) return (false, 'No hay un PIN configurado');
      if (e.code == auth_error.permanentlyLockedOut) return (false, 'Se requiere desbloquear el teléfono de nuevo');
      return (false, e.toString());
    }
  }
}
