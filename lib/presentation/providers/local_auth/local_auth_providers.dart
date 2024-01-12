import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/local_auth_plugin.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) => LocalAuthPlugin.canCheckBiometrics());

enum LocalAuthStatus { authenticated, notAuthenticated, authenticating }

class LocalAuthState {
  final bool didAuthenticate;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({this.didAuthenticate = false, this.status = LocalAuthStatus.notAuthenticated, this.message = ''});

  LocalAuthState copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? status,
    String? message,
  }) {
    return LocalAuthState(
      didAuthenticate: didAuthenticate ?? this.didAuthenticate,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'LocalAuthState(didAuthenticate: $didAuthenticate, status: ${status.name}, message: $message)';
}

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier() : super(LocalAuthState());

  Future<(bool, String)> authenticateUser() async {
    final (didAuth, message) = await LocalAuthPlugin.authenticate();

    state = state.copyWith(
      didAuthenticate: didAuth,
      message: message,
      status: didAuth ? LocalAuthStatus.authenticated : LocalAuthStatus.notAuthenticated,
    );

    return (didAuth, message);
  }
}

final localAuthProvider = StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) => LocalAuthNotifier());
