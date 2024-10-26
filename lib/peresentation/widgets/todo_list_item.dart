import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo.dart';
import 'manage_todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  TodoListItem({Key? key, required this.todo}) : super(key: key);

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (ctx) => ManageTodo(
        todo: todo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      child: ListTile(
        leading: IconButton(
          onPressed: () => context.read<TodoBloc>().add(TogleTodoEvent(todo.id)),
          icon: Icon(
            todo.isDone
                ? Icons.check_circle_outline_rounded
                : Icons.circle_outlined,
            color: todo.isDone ? Colors.green : Colors.white, // UI yaxshilash
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            color: todo.isDone ? Colors.grey : Colors.white, // Rang o'zgarishi
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => context.read<TodoBloc>().add(DeleteTodoEvent(todo.id)),
              icon: const Icon(Icons.delete),
              color: Colors.red, // Delete icon qizil bo'lishi
            ),
            IconButton(
              onPressed: () => openManageTodo(context),
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}