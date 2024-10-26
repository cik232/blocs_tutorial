import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarr extends SearchDelegate {
  @override
ThemeData appBarTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.transparent,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(), // Android uchun minimal animatsiya
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // iOS uchun minimal animatsiya
    }),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            query = '';
          },
          child: Text(
            "CLEAR",
            style: TextStyle(color: Colors.white),
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.read<TodoBloc>().searchTodos(query);
    return todos.isEmpty
        ? const Center(
            child: Text(
            'Cam\'t find todos.',
            style: TextStyle(color: Colors.white),
          ))
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (ctx, i) => ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/todo-detayls', arguments: todos[i]);
                  },
                  title: Card(
                      child: Text(
                    todos[i].title,
                    style: TextStyle(color: Colors.white),
                  )),
                ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final todos = context.read<TodoBloc>().searchTodos(query);
      return todos.isEmpty
          ? const Center(
              child: Text(
              'Cam\'t find todos.',
              style: TextStyle(color: Colors.white),
            ))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, i) => ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/todo-detayls', arguments: todos[i]);
                    },
                    title: Container(
                        height: 50,
                        child: Card(
                            color: Colors.white30,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todos[i].title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.navigate_next_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )))),
                  ));
    }
    return Container();
  }
}
