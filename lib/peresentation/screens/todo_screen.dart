import 'package:bloc_tutorial_todo_app/logic/blocs/activ_todos/activ_todos_bloc.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/completed_todos_bloc/completed_todos_bloc.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/constants/tab_titles_constants.dart';
import '../widgets/search_barr.dart';
import '../widgets/manage_todo.dart';
import '../widgets/todo_list_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _init = false;
  @override
  void didChangeDependencies() {
    if (!_init) {
      context.read<TodoBloc>().add(LoadTodosEvent());
      // context.read<ActivTodosCubit>().getActiveTodos();
      context.read<ActivTodosBloc>().add(LoadActiveTodosEvent());
      // context.read<CpmopletedTodosCubit>().getCpmopletedTodos();
      context.read<CompletedTodosBloc>().add(LoadCompletedTodosEvent());
    }
    _init = true;
    super.didChangeDependencies();
  }

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (ctx) => ManageTodo(),
    );
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBarr());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitlesConstants.tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Sizning Kun Tartiblaringiz",style: TextStyle(fontSize: 20,color: Colors.white),),
          centerTitle: false,

          actions: [
            IconButton(
              onPressed: () => openSearchBar(context),
              icon: Icon(Icons.search_outlined,color: Colors.white,),
            ),
            IconButton(
              onPressed: () => openManageTodo(context),
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.green,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            tabs: TabTitlesConstants.tabs.map((tab) => Tab(text: tab)).toList(),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) =>
                              TodoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
            BlocBuilder<ActivTodosBloc, ActivTodosState>(
              builder: (context, state) {
                 if (state is ActiveTodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) =>
                              TodoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
            BlocBuilder<CompletedTodosBloc, CompletedTodosState >(
              builder: (context, state) {
                 if (state is CompletedTodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) =>
                              TodoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
