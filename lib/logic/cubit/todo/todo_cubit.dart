import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import 'user/user_cubit.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserCubit userCubit;
  TodoCubit({required this.userCubit})
      : super(
          TodoInitial(
            [
              Todo(
                id: UniqueKey().toString(),
                title: "Go Home",
                isDone: false,
                userId: '1',
              ),
              Todo(
                id: UniqueKey().toString(),
                title: "Go Shopping",
                isDone: true,
                userId: '1',
              ),
              Todo(
                id: UniqueKey().toString(),
                title: "Go Home",
                isDone: false,
                userId: '2',
              ),
            ],
          ),
        );

  void getTodos() {
    final user = userCubit.currentUser;
    final todos =
        state.todos!.where((todos) => todos.userId == user.id).toList();
        print(todos);
    emit(TodosLoaded(todos));
  }

  void addTodo(String title) {
    final user = userCubit.currentUser;
    try {
      final todo = Todo(
        id: UniqueKey().toString(),
        title: title,
        userId: user.id,
      );
      final todos = [...?state.todos, todo]; // Null tekshirish
      emit(TodoAdded());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occurred'));
    }
  }

  void editTodo(String id, String title) {
    try {
      final todos = state.todos?.map((t) {
        if (t.id == id) {
          return Todo(id: id, title: title, isDone: t.isDone, userId: t.userId);
        }
        return t;
      }).toList();
      if (todos != null) {
        emit(TodoEdited());
        emit(TodosLoaded(todos));
      }
    } catch (e) {
      emit(const TodoError('Error occurred'));
    }
  }

  void toggleTodo(String id) {
    final todos = state.todos?.map((todo) {
      if (todo.id == id) {
        return Todo(
            id: id,
            title: todo.title,
            isDone: !todo.isDone,
            userId: todo.userId);
      }
      return todo;
    }).toList();
    if (todos != null) {
      emit(TodoToggled());
      emit(TodosLoaded(todos));
    }
  }

  void deletedTodo(String id) {
    final todos = state.todos;
    if (todos != null) {
      todos.removeWhere((todo) => todo.id == id);
      emit(TodoDeleted());
      emit(TodosLoaded(todos));
    }
  }

  List<Todo> searchTodos(String title) {
    return state.todos!
        .where((todo) => todo.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
