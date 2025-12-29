import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login({
    required String email,
    required String password,
    required String gender,
    required bool rememberMe,
  }) async {
    state = AuthState(isLoading: true);
    try {
      // Add your login logic here
      state = AuthState(isAuthenticated: true);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }
}


final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

final emailProvider = StateProvider.autoDispose<String>((ref) => '');

final passwordProvider = StateProvider.autoDispose<String>((ref) => '');

final rememberMeProvider = StateProvider.autoDispose<bool>((ref) => true);

final genderProvider = StateProvider.autoDispose<String?>((ref) => null);

final passwordVisibilityProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final textListProvider = StateProvider<List<String>>((ref) => ['Initial text']);

final uuidProvider = StateProvider<Uuid>((ref) => Uuid());


// Form Validation Provider
final isFormValidProvider = Provider.autoDispose<bool>((ref) {
  final email = ref.watch(emailProvider);
  final password = ref.watch(passwordProvider);
  final gender = ref.watch(genderProvider);

  return email.isNotEmpty &&
      email.contains('@') &&
      password.length >= 6 &&
      gender != null;
});
