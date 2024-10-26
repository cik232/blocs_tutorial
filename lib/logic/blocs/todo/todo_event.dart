part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent{}

class AddNewTodoEvent extends TodoEvent{
  final String title;
  AddNewTodoEvent(this.title);
}

class EditTodoEvent extends TodoEvent{
  final String id;
  final String toitle;
  EditTodoEvent(this.id, this.toitle);
}

class TogleTodoEvent extends TodoEvent{
  final String id;
  TogleTodoEvent(this.id);
}

class DeleteTodoEvent extends TodoEvent{
  final String id;
 
  DeleteTodoEvent(this.id);
}

