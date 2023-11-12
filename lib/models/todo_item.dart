import 'dart:convert';

class TodoItem {
  final int? id;
  final String task;
  final String description;
  final bool isDone;
  TodoItem({
    this.id,
    required this.task,
    required this.description,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id']?.toInt(),
      task: map['task'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) => TodoItem.fromMap(json.decode(source));

  TodoItem copyWith({
    int? id,
    String? task,
    String? description,
    bool? isDone,
  }) {
    return TodoItem(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'TodoItem(id: $id, task: $task, description: $description, isDone: $isDone)';
  }
}