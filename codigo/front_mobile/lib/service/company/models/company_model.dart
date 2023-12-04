import 'package:equatable/equatable.dart';

class CompanyModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String cnpj;
  final String phone;

  const CompanyModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.cnpj = '',
    this.phone = '',
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      cnpj: json['cnpj'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['cnpj'] = cnpj;
    data['phone'] = phone;

    return data;
  }

  @override
  List<Object> get props => [
        name,
        email,
        cnpj,
        phone,
      ];

  CompanyModel copyWith({
    String? name,
    String? email,
    String? cnpj,
    String? phone,
  }) {
    return CompanyModel(
      name: name ?? this.name,
      email: email ?? this.email,
      cnpj: cnpj ?? this.cnpj,
      phone: phone ?? this.phone,
    );
  }
}
