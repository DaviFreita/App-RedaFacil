class AuthEmailStatus {
  final bool exists;
  final String? provider;
  final bool emailConfirmed;

  const AuthEmailStatus({
    required this.exists,
    this.provider,
    required this.emailConfirmed,
  });
}
