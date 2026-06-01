import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserModelProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) async {
      if (user == null) return null;
      return ref.read(authServiceProvider).getCurrentUserModel();
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncData(null));

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authService.signInWithEmailPassword(email, password));
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authService.signInWithGoogle());
  }

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
    String? phoneNumber,
    String? agencyId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authService.registerWithEmailPassword(
          email: email,
          displayName: displayName,
          password: password,
          role: role,
          phoneNumber: phoneNumber,
          agencyId: agencyId,
        ));
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const AsyncData(null);
  }

  Future<void> sendPasswordReset(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }

  void clearError() {
    if (state.hasError) state = const AsyncData(null);
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});
