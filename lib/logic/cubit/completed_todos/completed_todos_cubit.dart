import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/todo.dart';
import 'package:meta/meta.dart';

import '../todo/todo_cubit.dart';

part 'completed_todos_state.dart';

class CpmopletedTodosCubit extends Cubit<CompletedTodosState> {
  late final StreamSubscription todoCubitSubscription;
  final TodoCubit todoCubit;
  CpmopletedTodosCubit(this.todoCubit) : super(CompletedTodosInitial()){
    todoCubitSubscription = todoCubit.stream.listen((TodoState state){
      getCpmopletedTodos();
    });
  }

  void getCpmopletedTodos(){
    final todos = todoCubit.state.todos!.where((todo)=>todo.isDone).toList();
    emit(CompletedTodosLoaded(todos)); 
  }

  @override
  Future<void> close() {
   todoCubitSubscription.cancel();
    return super.close();
  }

}
