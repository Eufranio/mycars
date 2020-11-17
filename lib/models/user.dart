class User {

  final String id,
      email,
      name,
      photo;

  const User([this.id, this.email, this.name, this.photo]);

  static const empty = User('', '', null, null);

}