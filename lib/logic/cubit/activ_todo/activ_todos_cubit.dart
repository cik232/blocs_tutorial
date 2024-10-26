import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/todo.dart';
import 'package:meta/meta.dart';
import '../todo/todo_cubit.dart';

part 'activ_todos_state.dart';

class ActivTodosCubit extends Cubit<ActivTodosState> {
  late final StreamSubscription todoCubitSubscription;
  final TodoCubit todoCubit;
  ActivTodosCubit(this.todoCubit) : super(ActivTodosInitial()){
    todoCubitSubscription = todoCubit.stream.listen((TodoState state){
      getActiveTodos();
    });
  }

  void getActiveTodos(){
    final todos = todoCubit.state.todos!.where((todo)=>!todo.isDone).toList();
    emit(ActiveTodosLoaded(todos)); 
  }

  @override
  Future<void> close() {
   todoCubitSubscription.cancel();
    return super.close();
  }

}
