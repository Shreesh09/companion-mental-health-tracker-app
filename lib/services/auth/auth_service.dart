import 'auth_provider.dart';
import 'auth_user.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() async {
    await provider.initialize();
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    final user = await provider.createUser(email: email, password: password);
    return user;
  }

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    final user = await provider.logIn(email: email, password: password);
    return user;
  }

  @override
  Future<void> logOut() async {
    await provider.logOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    provider.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) =>
      provider.sendPasswordReset(toEmail: toEmail);
}
