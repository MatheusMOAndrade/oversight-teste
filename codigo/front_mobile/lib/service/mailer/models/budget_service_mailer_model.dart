import 'package:equatable/equatable.dart';

class BudgetServiceMailerModel extends Equatable {
  final String name;
  final String quantity;
  final String value;

  const BudgetServiceMailerModel({
    this.name = '',
    this.quantity = '',
    this.value = '',
  });

  factory BudgetServiceMailerModel.fromJson(Map<String, dynamic> json) {
    return BudgetServiceMailerModel(
      name: json['name'],
      quantity: json['quantity'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['value'] = value;

    data['value'] = value;

    return data;
  }

  @override
  List<Object> get props => [
        name,
        quantity,
        value,
        value,
      ];

  BudgetServiceMailerModel copyWith({
    String? name,
    String? quantity,
    String? value,
  }) {
    return BudgetServiceMailerModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      value: value ?? this.value,
    );
  }
}
