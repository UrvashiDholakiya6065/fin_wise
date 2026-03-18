import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationModel({required this.title, required this.body, required this.timestamp});

  factory NotificationModel.fromJson( Map<String, dynamic> data) {
    return NotificationModel(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'title':title,
      'body':body,
      'timestamp':timestamp
    };
  }
}