class User {
  int id;
  var login;
  var type;
  var avatar_url;
  var repos_url;
  User({
    required this.login,
    required this.type,
    required this.id,
    required this.avatar_url,
    required this.repos_url,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      login: json['login'],
      type: json['type'],
      id: json['id'],
      avatar_url: json['avatar_url'],
      repos_url: json['repos_url']
    );
  }
}
class UserList {
  final List<User> list;
  UserList({required this.list});

  factory UserList.fromJson(List<dynamic> parsedJson) {
    var user =
    parsedJson.map((i) => User.fromJson(i)).toList();
    return new UserList(list: user);
  }
}