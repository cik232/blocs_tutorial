part of 'activ_todos_cubit.dart';

@immutable
abstract class ActivTodosState {}

class ActivTodosInitial extends ActivTodosState {}

class ActiveTodosLoaded extends ActivTodosState{
  final List<Todo> todos;

  ActiveTodosLoaded(this.todos);
} 