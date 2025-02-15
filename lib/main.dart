import 'package:bloc_todo/blocs/theme_bloc/bloc/theme_bloc.dart';
import 'package:bloc_todo/blocs/theme_bloc/bloc/theme_state.dart';
import 'package:bloc_todo/blocs/todo_bloc/todo_bloc.dart';
import 'package:bloc_todo/screens/todo_list_screen.dart';
import 'package:bloc_todo/services/api_servicees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ApiServicees todoService = ApiServicees();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => TodoBloc(todoService)..add(FetchTodos())),
      BlocProvider(create: (_) => ThemeBloc()),
    ],
    child: const Bloc(),
  ));
}

class Bloc extends StatelessWidget {
  const Bloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        title: 'Bloc Todo',
        theme: themeState.themeData,
        home: const TodoListScreen(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
