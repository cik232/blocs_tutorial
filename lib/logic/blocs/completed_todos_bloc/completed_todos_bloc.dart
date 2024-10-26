import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/todo.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';
import 'package:meta/meta.dart';

part 'completed_todos_event.dart';
part 'completed_todos_state.dart';

class CompletedTodosBloc extends Bloc<CompletedTodosEvent, CompletedTodosState> {
  late final StreamSubscription todoBlocSubscription;
  final TodoBloc todoBloc;
  CompletedTodosBloc(this.todoBloc) : super(CompletedTodosInitial()){
    todoBlocSubscription = todoBloc.stream.listen((event){add(LoadCompletedTodosEvent());});
    on<LoadCompletedTodosEvent>(_getCompletedTodos);
  }

 

 void _getCompletedTodos(LoadCompletedTodosEvent event, Emitter<CompletedTodosState>emit){
    final todos = todoBloc.state.todos!.where((todo)=>todo.isDone).toList();
    emit(CompletedTodosLoaded(todos)); 
  }

  @override
  Future<void> close() {
    todoBlocSubscription.cancel();
    return super.close();
  }

}
