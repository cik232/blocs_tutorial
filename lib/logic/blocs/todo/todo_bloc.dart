import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/todo.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserBloc userBloc;

  TodoBloc(this.userBloc) : super(TodoInitial([])) {
    _loadTodosFromPreferences();
    on<LoadTodosEvent>(_getTodos);
    on<AddNewTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<TogleTodoEvent>(_toggleTodo);
    on<DeleteTodoEvent>(_deletedTodo);
  }

  Future<void> _loadTodosFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString('todos');
    if (todosString != null) {
      final List<dynamic> todoJsonList = jsonDecode(todosString);
      final todos = todoJsonList.map((json) => Todo.fromJson(json)).toList();
      emit(TodosLoaded(todos));
    }
  }

  Future<void> _saveTodosToPreferences(List<Todo> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => todo.toJson()).toList();
    await prefs.setString('todos', jsonEncode(todosJson));
  }

  void _getTodos(LoadTodosEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;
    final todos = state.todos!.where((todo) => todo.userId == user.id).toList();
    emit(TodosLoaded(todos));
  }

  void _addTodo(AddNewTodoEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;
    final todo = Todo(
      id: UniqueKey().toString(),
      title: event.title,
      userId: user.id,
    );
    final todos = [...?state.todos, todo];
    emit(TodoAdded());
    emit(TodosLoaded(todos));
    _saveTodosToPreferences(todos);
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos?.map((t) {
      if (t.id == event.id) {
        return Todo(
          id: event.id,
          title: event.toitle,
          isDone: t.isDone,
          userId: t.userId,
        );
      }
      return t;
    }).toList();
    if (todos != null) {
      emit(TodoEdited());
      emit(TodosLoaded(todos));
      _saveTodosToPreferences(todos);
    }
  }

  void _toggleTodo(TogleTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos?.map((todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          title: todo.title,
          isDone: !todo.isDone,
          userId: todo.userId,
        );
      }
      return todo;
    }).toList();
    if (todos != null) {
      emit(TodoToggled());
      emit(TodosLoaded(todos));
      _saveTodosToPreferences(todos);
    }
  }

  void _deletedTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos;
    if (todos != null) {
      todos.removeWhere((todo) => todo.id == event.id);
      emit(TodoDeleted());
      emit(TodosLoaded(todos));
      _saveTodosToPreferences(todos);
    }
  }

  List<Todo> searchTodos(String title) {
    return state.todos!
        .where((todo) => todo.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}