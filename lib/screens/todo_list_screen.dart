import 'package:bloc_todo/blocs/theme_bloc/bloc/theme_bloc.dart';
import 'package:bloc_todo/blocs/theme_bloc/bloc/theme_event.dart';
import 'package:bloc_todo/blocs/todo_bloc/todo_bloc.dart';
import 'package:bloc_todo/screens/add_and_update.dart';
import 'package:bloc_todo/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final currentState = context.read<TodoBloc>().state;
    // log('$currentState read');
    //  final current =context.watch<TodoBloc>().state;
    //  log('$current watch');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ThemeEvent.toggle);
                },
                icon: isDarkMode
                    ? const Icon(Icons.dark_mode_outlined)
                    : const Icon(Icons.light_mode_outlined)),
          ],
          title: const Text(
            'Tasks BLoC',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 10),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Complete'),
              Tab(text: 'Incomplete'),

            ],
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
          if (state is Todoloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoeaded) {
            return TabBarView(
              children: [
                TodoScreen(todoList: state.todos),
                TodoScreen(
                    todoList: state.todos
                        .where((element) => element.isCompleted == true)
                        .toList()),
                TodoScreen(
                    todoList: state.todos
                        .where((element) => element.isCompleted == false)
                        .toList()),
                        
              ],
            );
          } else if (state is TodoError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddAndUpdate()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
