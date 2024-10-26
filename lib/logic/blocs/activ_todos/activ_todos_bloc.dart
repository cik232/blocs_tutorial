import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/todo.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';
import 'package:meta/meta.dart';

part 'activ_todos_event.dart';
part 'activ_todos_state.dart';

class ActivTodosBloc extends Bloc<ActivTodosEvent, ActivTodosState> {
  late final StreamSubscription todoBlocSubscription;
  final TodoBloc todoBloc;
  ActivTodosBloc(this.todoBloc) : super(ActivTodosInitial()){
    todoBlocSubscription = todoBloc.stream.listen((event){add(LoadActiveTodosEvent());});
    on<LoadActiveTodosEvent>(_getActiveTodos);
  }
 

 void _getActiveTodos(LoadActiveTodosEvent event, Emitter<ActivTodosState>emit){
    final todos = todoBloc.state.todos!.where((todo)=>!todo.isDone).toList();
    emit(ActiveTodosLoaded(todos)); 
  }

  @override
  Future<void> close() {
    todoBlocSubscription.cancel();
    return super.close();
  }

}
