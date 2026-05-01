import 'package:flutter/material.dart';

class ProcessStepData {
  final String step;
  final String title;
  final String description;
  final IconData icon;

  ProcessStepData({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class TimelineData {
  final String date;
  final String event;
  final String status;

  TimelineData({
    required this.date,
    required this.event,
    required this.status,
  });
}

class ChatMessage {
  final String role;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.role,
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    role: json['role'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
