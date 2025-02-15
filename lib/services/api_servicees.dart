import 'dart:convert';

import 'package:bloc_todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServicees {
  String baseUrl = 'https://api.nstack.in';

  Future<List<TodoModel>> getAllTodos() async {
    var response = await http.get(Uri.parse('$baseUrl/v1/todos'));
    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      final jsonresponse = jsonDecode(response.body) as Map<String, dynamic>;
      final result = jsonresponse['items'] as List;
      return result.map((data) => TodoModel.fromJson(data)).toList();
    } else {
      throw Exception('api error');
    }
  }

  Future<TodoModel> addTodo(TodoModel todo) async {
    var response = await http.post(Uri.parse('$baseUrl/v1/todos'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": todo.title,
          "description": todo.description,
          "is_completed": todo.isCompleted
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(jsonDecode(response.body).toString());
      final data = TodoModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('api error of adding');
    }
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    var response = await http.put(Uri.parse('$baseUrl/v1/todos/${todo.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": todo.title,
          "description": todo.description,
          "is_completed": todo.isCompleted
        }));
    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      final data = TodoModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('api error');
    }
  }

  Future<void> deleteTodo(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/v1/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('api error');
    }
  }
}
