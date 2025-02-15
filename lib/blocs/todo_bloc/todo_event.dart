part of 'todo_bloc.dart';


sealed class TodoEvent {}

class FetchTodos extends TodoEvent {}

class Addtodo extends TodoEvent {
  final TodoModel todo;
  Addtodo(this.todo);
}
class Updatetodo extends TodoEvent {
  final TodoModel todo;
  Updatetodo(this.todo);
}
class Deletetodo extends TodoEvent {
  final String id;
  Deletetodo(this.id);
}
