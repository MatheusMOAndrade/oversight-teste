import 'package:equatable/equatable.dart';

class ServiceModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String mesureUnit;
  final int value;
  final String type;
  final int errorMargin;

  const ServiceModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.mesureUnit = '',
    this.value = 0,
    this.type = '',
    this.errorMargin = 0,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final value = json['value'].toInt() ?? 0;

    final errorMargin = json['errorMargin'].toInt() ?? 0;

    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      mesureUnit: json['mesureUnit'],
      value: value,
      type: json['type'],
      errorMargin: errorMargin,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['mesureUnit'] = mesureUnit;
    data['value'] = value;
    data['type'] = type;
    data['errorMargin'] = errorMargin;

    return data;
  }

  @override
  List<Object> get props => [
        id,
        name,
        description,
        mesureUnit,
        value,
        type,
        errorMargin,
      ];

  ServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    String? mesureUnit,
    int? value,
    String? type,
    int? errorMargin,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      mesureUnit: mesureUnit ?? this.mesureUnit,
      value: value ?? this.value,
      type: type ?? this.type,
      errorMargin: errorMargin ?? this.errorMargin,
    );
  }
}
