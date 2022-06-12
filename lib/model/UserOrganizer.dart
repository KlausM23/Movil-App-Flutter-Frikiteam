class UserOrganizer {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String logo;
  final String description;
  final bool verified;

  UserOrganizer(this.id, this.firstName, this.lastName, this.email, this.password, this.logo,
      this.description, this.verified);
}