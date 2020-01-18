class User {
  final String uid;
  final String name;
  final String creationDate;

  User(
    this.uid,
    this.name, {
    this.creationDate,
  });

  @override
  String toString() {
    return "UID : " + uid + ", Name : " + name;
  }
}
