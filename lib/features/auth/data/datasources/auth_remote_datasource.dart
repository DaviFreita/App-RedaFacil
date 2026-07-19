import '../../domain/entities/auth_email_status.dart';
import '../../domain/entities/auth_user.dart';

abstract class AuthRemoteDatasource {
  Future<AuthUser> signIn({required String email, required String password});

  Future<AuthUser> signUp({required String email, required String password});

  Future<void> signInWithGoogle();

  Future<void> resetPassword({required String email});

  Future<void> signOut();

  Future<AuthUser?> currentUser();

  Stream<AuthUser?> authStateChanges();

  Future<AuthEmailStatus> checkEmail(String email);
}
