class MyUser {
  final String id;
  final String username;
  final String email;
  final String birdhdate;
  final String tel;
  final List<dynamic> favoriteLoads;

  const MyUser({
    required this.id,
    required this.username,
    required this.email,
    required this.birdhdate,
    required this.tel,
    required this.favoriteLoads,
  });

  factory MyUser.fromfirestore(Map<String, dynamic> map) {
    return MyUser(
      id: map['uid'] ?? 'null',
      username: map['username'] ?? 'null',
      email: map['email'] ?? 'null',
      birdhdate: map['birdhdate'] ?? 'null',
      tel: map['tel'] ?? 'null',
      favoriteLoads: map['favoriteLoads'] ?? 'null',
    );
  }

  Map<String, dynamic> toFirestore() => {
        'uid': id,
        'username': username,
        'email': email,
        'birdhdate': birdhdate,
        'tel': tel,
        'favoriteLoads': favoriteLoads,
      };
}
