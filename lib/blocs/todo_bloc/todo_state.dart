part of 'todo_bloc.dart';


sealed class TodoState {}

final class TodoInitial extends TodoState {}

class Todoloading extends TodoState {}

class TodoLoeaded extends TodoState {
  final List<TodoModel> todos;
  TodoLoeaded(this.todos);
}
class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}