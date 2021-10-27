class Account {
  final String id;
  final String? username;
  final String? email;
  final String? password;
  //final bool? isAdmin;
  Account(
    this.id, {
    this.username,
    this.email,
    this.password,
    //this.isAdmin = false,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        json["uid"],
        username: json["name"],
        email: json["email"],
        //isAdmin: json["isAdmin"] ?? false,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "uid": id,
        "name": username,
        "email": email,
        //"isAdmin": isAdmin,
      };
}
