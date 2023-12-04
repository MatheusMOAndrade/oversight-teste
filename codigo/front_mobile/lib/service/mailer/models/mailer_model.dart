import 'package:equatable/equatable.dart';

class MailerModel extends Equatable {
  final String id;
  final String from;
  final String to;
  final String subject;
  final String text;
  final String html;

  const MailerModel({
    this.id = '',
    this.from = '',
    this.to = '',
    this.subject = '',
    this.text = '',
    this.html = '',
  });

  factory MailerModel.fromJson(Map<String, dynamic> json) {
    return MailerModel(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      subject: json['subject'],
      text: json['text'],
      html: json['html'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['subject'] = subject;
    data['text'] = text;
    data['html'] = html;

    return data;
  }

  @override
  List<Object> get props => [
        from,
        to,
        subject,
        text,
        html,
      ];

  MailerModel copyWith({
    String? from,
    String? to,
    String? subject,
    String? text,
    String? html,
  }) {
    return MailerModel(
      from: from ?? this.from,
      to: to ?? this.to,
      subject: subject ?? this.subject,
      text: text ?? this.text,
      html: html ?? this.html,
    );
  }
}
