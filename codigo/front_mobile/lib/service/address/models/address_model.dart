import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String customerId;
  final String cep;
  final String street;
  final int number;
  final String complement;

  const AddressModel({
    this.customerId = '',
    this.cep = '',
    this.street = '',
    this.number = 0,
    this.complement = '',
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    //final number = json['number'].toInt() ?? 0;

    return AddressModel(
      customerId: json['customerId'],
      cep: json['cep'],
      street: json['street'],
      number: json['number'],
      complement: json['complement'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['cep'] = cep;
    data['street'] = street;
    data['number'] = number;
    data['complement'] = complement;

    return data;
  }

  @override
  List<Object> get props => [
        cep,
        street,
        number,
        complement,
        customerId,
      ];

  AddressModel copyWith(
      {String? cep,
      String? street,
      int? number,
      String? complement,
      String? customerId}) {
    return AddressModel(
        cep: cep ?? this.cep,
        street: street ?? this.street,
        number: number ?? this.number,
        complement: complement ?? this.complement,
        customerId: customerId ?? this.customerId);
  }
}
