import 'package:equatable/equatable.dart';

class BudgetServiceModel extends Equatable {
  final String serviceId;
  final String budgetId;
  final int quantity;
  final double budgetedUnitValue;

  const BudgetServiceModel({
    this.serviceId = '',
    this.budgetId = '',
    this.quantity = 0,
    this.budgetedUnitValue = 0,
  });

  factory BudgetServiceModel.fromJson(Map<String, dynamic> json) {
    final quantity = json['quantity'].toInt() ?? 0;

    final budgetedUnitValue = json['budgetedUnitValue'].toDouble() ?? 0.0;

    return BudgetServiceModel(
      budgetId: json['budgetId'],
      serviceId: json['serviceId'],
      budgetedUnitValue: budgetedUnitValue,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budgetId'] = budgetId;
    data['serviceId'] = serviceId;
    data['budgetedUnitValue'] = budgetedUnitValue;
    data['quantity'] = quantity;

    return data;
  }

  @override
  List<Object> get props => [
        budgetId,
        serviceId,
        budgetedUnitValue,
        quantity,
      ];

  BudgetServiceModel copyWith({
    String? budgetId,
    String? serviceId,
    double? budgetedUnitValue,
    int? quantity,
  }) {
    return BudgetServiceModel(
      budgetId: budgetId ?? this.budgetId,
      serviceId: serviceId ?? this.serviceId,
      budgetedUnitValue: budgetedUnitValue ?? this.budgetedUnitValue,
      quantity: quantity ?? this.quantity,
    );
  }
}
