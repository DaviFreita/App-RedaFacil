import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../domain/entities/auth_user.dart';
import 'auth_remote_datasource.dart';
import '../models/auth_email_status_model.dart';

import '../../domain/entities/auth_email_status.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Falha ao autenticar.');
    }

    return _mapUser(user);
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Falha ao cadastrar usuário.');
    }

    return _mapUser(user);
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    final success = await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: null,
    );

    if (!success) {
      throw Exception('Falha no login com Google.');
    }

    throw UnimplementedError(
      'O usuário será retornado através do authStateChanges().',
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<AuthUser?> currentUser() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    return _mapUser(user);
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _supabase.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;

      if (user == null) return null;

      return _mapUser(user);
    });
  }

  @override
  Future<bool> emailExists(String email) async {
    final response = await _supabase.functions.invoke(
      'check-email',
      body: {'email': email},
    );

    if (response.data == null) {
      throw Exception('Erro ao verificar e-mail.');
    }

    return response.data['exists'] as bool;
  }

  @override
  Future<AuthEmailStatus> checkEmail(String email) async {
    final response = await _supabase.rpc(
      'check_auth_email',
      params: {'p_email': email},
    );

    return AuthEmailStatusModel.fromJson(
      Map<String, dynamic>.from(response),
    ).toEntity();
  }

  AuthUser _mapUser(User user) {
    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'],
      photoUrl: user.userMetadata?['avatar_url'],
    );
  }
}
