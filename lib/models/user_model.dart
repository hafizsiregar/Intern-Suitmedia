class Data {
    Data({
        this.page,
        this.perPage,
        this.total,
        this.totalPages,
        required this.data,        
    });

    final int? page;
    final int? perPage;
    final int? total;
    final int? totalPages;
    final List<User> data;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data:  List<User>.from(json["data"].map((x) => User.fromJson(x))),       
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),        
    };
}

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  User({
    required this.id, 
    required this.email, 
    required this.firstName, 
    required this.lastName, 
    required this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar
    };
  }
}