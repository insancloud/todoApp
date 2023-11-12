import 'package:dio/dio.dart';

import '../models/todo_item.dart';

class NetworkManager {
  late final Dio _dio;
  final baseUrl =
      "https://8cdd-103-144-132-63.ngrok-free.app";

  NetworkManager() {
    _dio = Dio();
  }

  // Cek todo isDone
  Future<List<TodoItem>> getTodosIsDone(bool isDone) async {
    final result = await _dio.get(
      "$baseUrl/todos?isDone=$isDone",
    );
    return (result.data as List).map((e) => TodoItem.fromMap(e)).toList();
  }

  // Post Data Todo
  Future<TodoItem> postData(TodoItem item) async {
    final result = await _dio.post("$baseUrl/todos", data: item.toMap());
    return TodoItem.fromMap(result.data);
  }

  // Updata Data todo
  Future<TodoItem> updateData(TodoItem item) async {
    final result =
        await _dio.put("$baseUrl/todos/${item.id}", data: item.toMap());
    return TodoItem.fromMap(result.data);
  }

  // Delete Data Todo
  Future<void> deleteData(TodoItem item) async {
    await _dio.delete(
      "$baseUrl/todos/${item.id}",
    );
  }
}
