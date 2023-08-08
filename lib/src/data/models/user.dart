class MyUser {
  final String id;
  final String username;
  final String email;
  final String birdhdate;
  final String tel;
  final List<String> favoritesLoads;

  const MyUser({
    required this.id,
    required this.username,
    required this.email,
    required this.birdhdate,
    required this.tel,
    required this.favoritesLoads,
  });

  factory MyUser.fromfirestore(Map<String, dynamic> map) {
    return MyUser(
        id: map['uid'],
        username: map['username'],
        email: map['email'],
        birdhdate: map['birdhdate'],
        tel: map['tel'],
        favoritesLoads: map['favoritesLoads']);
  }
}
