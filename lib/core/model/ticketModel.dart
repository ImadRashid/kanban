import 'package:appflowy_board/appflowy_board.dart';

class TicketModel extends AppFlowyGroupItem {
  String title;
  String description;
  String createdAt;
  String status;

  TicketModel({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  @override
  String get id => title;

  toJson() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'status': status,
    };
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        title: json['title'],
        description: json['description'],
        createdAt: json['createdAt'],
        status: json['status'],
      );
}
