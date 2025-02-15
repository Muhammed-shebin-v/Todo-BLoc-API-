import 'package:bloc_todo/blocs/todo_bloc/todo_bloc.dart';
import 'package:bloc_todo/models/todo_model.dart';
import 'package:bloc_todo/utils/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAndUpdate extends StatefulWidget {
  final TodoModel? todo;
  const AddAndUpdate({super.key, this.todo});

  @override
  State<AddAndUpdate> createState() => AddAndUpdateState();
}

class AddAndUpdateState extends State<AddAndUpdate> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isComplete = false;
  final _formkey=GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.todo != null) {
      title.text = widget.todo?.title ?? '';
      description.text = widget.todo?.description ?? '';
      isComplete = widget.todo?.isCompleted ?? false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add ToDo' : 'Update ToDo',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Form(
          key: _formkey,
          child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Invalid';
                    }
                    return null; 
                  },
                  autofocus: widget.todo == null ? true : false,
                  autocorrect: false,
                  controller: title,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      hintText: 'Title', border: InputBorder.none),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Invalid';
                    }
                    return null; 
                  },
                  autocorrect: false,
                  controller: description,
                  style: const TextStyle( fontSize: 20),
                  decoration: const InputDecoration(
                  hintText: 'Description', border: InputBorder.none),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'complete ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                        value: isComplete,
                        onChanged: (bool value) {
                          setState(() {
                            isComplete = value;
                          });
                        })
                  ],
                ),
              ],
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (title.text.isEmpty) {
              commonToast(context, 'Please Enter Title');
            } else if (description.text.isEmpty) {
              commonToast(context, 'Please Enter Description');
            } else {
              if(_formkey.currentState!.validate()){
              if (widget.todo == null){
                BlocProvider.of<TodoBloc>(context).add(Addtodo(TodoModel(
                    id: '',
                    createAt: DateTime.now(),
                    title: (title.text[0].toUpperCase() + title.text.substring(1)).trim(),
                    description: description.text.trim(),
                    isCompleted:isComplete)));
                title.clear();
                description.clear();
                commonToast(context, 'Todo Added',bgcolor: Colors.green);
                Navigator.pop(context);
              } else {
                BlocProvider.of<TodoBloc>(context).add(Updatetodo(TodoModel(
                    id: widget.todo!.id,
                    createAt: widget.todo!.createAt,
                    title: (title.text[0].toUpperCase() + title.text.substring(1)).trim(),
                    description: description.text.trim(),
                    isCompleted:isComplete)));
                title.clear();
                description.clear();
                commonToast(context, 'Todo Updated',bgcolor: Colors.green);
                Navigator.pop(context);
              }
            }
            }
          },
          child:const Icon(Icons.done)),
    );
  }
}
