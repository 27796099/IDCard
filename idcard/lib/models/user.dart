class Users {
  final String uid;
  Users({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String position;
  final String address;
  UserData(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.position,
      required this.address});
}
