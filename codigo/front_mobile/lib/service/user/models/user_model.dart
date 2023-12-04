import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;

  const UserModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.role = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;

    return data;
  }

  Map<String, dynamic> toJsonPut() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['role'] = role;

    return data;
  }

  @override
  List<Object> get props => [
        name,
        email,
        password,
        role,
      ];

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? role,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}
