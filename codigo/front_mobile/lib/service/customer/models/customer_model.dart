import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String createdAt;

  const CustomerModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.createdAt = '',
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['createdAt'] = createdAt;

    return data;
  }

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        createdAt,
      ];

  CustomerModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? createdAt,
  }) {
    return CustomerModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
