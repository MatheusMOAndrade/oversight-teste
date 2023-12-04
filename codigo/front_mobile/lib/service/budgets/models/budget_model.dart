import 'package:equatable/equatable.dart';

class BudgetModel extends Equatable {
  final String id;
  final String name;
  final String customerId;
  final String description;
  final int incomingMargin;
  final String status;

  const BudgetModel({
    this.id = '',
    this.name = '',
    this.customerId = '',
    this.description = '',
    this.incomingMargin = 0,
    this.status = '',
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    final incomingMargin = json['incomingMargin'].toInt() ?? 0;

    return BudgetModel(
      id: json['id'],
      customerId: json['customerId'],
      name: json['name'],
      description: json['description'],
      incomingMargin: incomingMargin,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['name'] = name;
    data['description'] = description;
    data['incomingMargin'] = incomingMargin;
    data['status'] = status;

    return data;
  }

  @override
  List<Object> get props => [
        name,
        customerId,
        description,
        incomingMargin,
        status,
      ];

  BudgetModel copyWith({
    String? name,
    String? customerId,
    String? description,
    int? incomingMargin,
    String? status,
  }) {
    return BudgetModel(
      name: name ?? this.name,
      customerId: customerId ?? this.customerId,
      description: description ?? this.description,
      incomingMargin: incomingMargin ?? this.incomingMargin,
      status: status ?? this.status,
    );
  }
}
