import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo.dart';

class ManageTodo extends StatelessWidget {
  final Todo? todo;
  ManageTodo({
    Key? key,
    this.todo,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String _title = '';

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (todo == null) {
        // context.read<TodoCubit>().addTodo(_title);
        context.read<TodoBloc>().add(AddNewTodoEvent(_title));
      } else {
        // context.read<TodoCubit>().editTodo(
          // todo!.id,
          // _title,
        // );
        context.read<TodoBloc>().add(EditTodoEvent(todo!.id, _title));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoAdded || state is TodoEdited) {
            Navigator.of(context).pop();
          } else if (state is TodoError) {
            showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Error"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(); // Dialogni yopish
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Kichik ekranda kengaytirib yubormaslik uchun
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Title'),
                    initialValue: todo?.title ?? '', // `todo == null ? '' : todo.title` o'rniga
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,width: 120,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("CANCEL"),
                          ),
                        ),
                        Container(
                          height: 40,width: 120,
                          child: ElevatedButton(
                            onPressed: () => _submit(context),
                            child: Text(todo == null ? "ADD" : "EDIT"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}