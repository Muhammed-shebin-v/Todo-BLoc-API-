import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo/models/todo_model.dart';
import 'package:bloc_todo/services/api_servicees.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServicees todoservice;

  TodoBloc(this.todoservice) : super(TodoInitial()) {
    on<FetchTodos>((event,emit)async{
      emit(Todoloading());
      try{
       final todos=await todoservice.getAllTodos();
       emit(TodoLoeaded(todos));
       log('fetched');
      }catch(e){
        emit(TodoError(e.toString()));
      }
    });

    on<Addtodo>((event,emit)async{
      try{
        await todoservice.addTodo(event.todo);
        add(FetchTodos());
        log('added');
      }catch(e){
        emit(TodoError(e.toString()));
      }
    });

    on<Updatetodo>((event,emit)async{
      try{
        await todoservice.updateTodo(event.todo);
        add(FetchTodos());
        log('updated');
      }catch(e){
        emit(TodoError(e.toString()));
      }
    });

    on<Deletetodo>((event,emit)async{
      try{
        await todoservice.deleteTodo(event.id);
        add(FetchTodos());
      }
      catch(e){
        emit(TodoError(e.toString()));
      }
    });
  }


}
