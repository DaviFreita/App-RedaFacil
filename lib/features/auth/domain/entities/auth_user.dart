class AuthUser {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;

  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
  });
}
