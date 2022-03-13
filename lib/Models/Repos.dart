class Repo {
  int id;
  var name;
  // ignore: non_constant_identifier_names
  var full_name;
  var html_url;
  var type;
  Repo({
    required this.id,
    required this.type,
    required this.full_name,
    required this.html_url,
    required this.name,
  });

  factory Repo.fromJson(Map<dynamic, dynamic> json) {
    return Repo(
      name: json['name'],
      type: json['type'],
      id: json['id'],
      full_name: json['full_name'],
      html_url: json['html_urll']
    );
  }
}
class RepoList {
  final List<Repo> list;
  RepoList({required this.list});

  factory RepoList.fromJson(List<dynamic> parsedJson) {
    var repo =
    parsedJson.map((i) => Repo.fromJson(i)).toList();
    return new RepoList(list: repo);
  }
}