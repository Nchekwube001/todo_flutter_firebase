// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.date,
    required this.isComplete,
  });

  final String id;
  final String title;
  final String description;
  final String priority;
  final String date;
  final bool isComplete;

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? date,
    bool? isComplete,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'date': date,
      'isComplete': isComplete,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      priority: map['priority'] as String,
      date: map['date'] as String,
      isComplete: map['isComplete'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, priority: $priority, date: $date, isComplete: $isComplete)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.date == date &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        date.hashCode ^
        isComplete.hashCode;
  }
}
