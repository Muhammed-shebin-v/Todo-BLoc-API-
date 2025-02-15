import 'package:bloc_todo/blocs/todo_bloc/todo_bloc.dart';
import 'package:bloc_todo/models/todo_model.dart';
import 'package:bloc_todo/screens/add_and_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatelessWidget {
  final List<TodoModel> todoList;
  const TodoScreen({super.key, required this.todoList});
  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? const Center(
            child: Text('Todo Not found'),
          )
        : ListView.separated(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              int reversedIndex = todoList.length - 1 - index;
              final TodoModel todo = todoList[reversedIndex];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAndUpdate(todo: todo)));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        Text(
                          DateFormat('dd-MM-yyyy').format(todo.createAt),
                          style: const TextStyle(fontSize: 12),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              todo.title,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text('Delete Todo'),
                                          content: const Text(
                                              'Do you want to delete this Todo'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel',
                                                    style: TextStyle(
                                                        color: Colors.blue))),
                                            TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<TodoBloc>(
                                                          context)
                                                      .add(Deletetodo(todo.id));
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        ));
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          todo.description,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Divider(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            todo.isCompleted == true
                                ? 'complete'
                                : 'Incomplete',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          );
  }
}
