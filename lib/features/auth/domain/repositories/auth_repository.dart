import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> signIn({required String email, required String password});

  Future<AuthUser> signUp({required String email, required String password});

  Future<AuthUser> signInWithGoogle();

  Future<void> resetPassword(String email);

  Future<void> signOut();

  Future<AuthUser?> currentUser();

  Stream<AuthUser?> authStateChanges();
}
