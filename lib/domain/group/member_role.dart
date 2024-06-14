enum MemberRole {
  basic,
  admin;

  static MemberRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'basic':
        return MemberRole.basic;
      case 'admin':
        return MemberRole.admin;
      default:
        return MemberRole.basic;
    }
  }

  @override
  String toString() {
    switch (this) {
      case MemberRole.basic:
        return 'basic';
      case MemberRole.admin:
        return 'admin';
    }
  }
}
