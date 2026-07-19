import '../../domain/entities/auth_email_status.dart';

class AuthEmailStatusModel {
  final bool exists;
  final String? provider;
  final bool emailConfirmed;

  const AuthEmailStatusModel({
    required this.exists,
    this.provider,
    required this.emailConfirmed,
  });

  factory AuthEmailStatusModel.fromJson(Map<String, dynamic> json) {
    return AuthEmailStatusModel(
      exists: json['exists'] as bool,
      provider: json['provider'] as String?,
      emailConfirmed: json['email_confirmed'] as bool? ?? false,
    );
  }

  AuthEmailStatus toEntity() {
    return AuthEmailStatus(
      exists: exists,
      provider: provider,
      emailConfirmed: emailConfirmed,
    );
  }
}
