import 'package:bloc_tutorial_todo_app/logic/blocs/activ_todos/activ_todos_bloc.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/completed_todos_bloc/completed_todos_bloc.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/user/user_bloc.dart';
import 'package:bloc_tutorial_todo_app/logic/blocs/todo/todo_bloc.dart';

import 'peresentation/screens/todo_detayls_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'peresentation/screens/todo_screen.dart';
// import 'logic/cubit/activ_todo/activ_todos_cubit.dart';
// import 'logic/cubit/completed_todos/completed_todos_cubit.dart';
// import 'logic/cubit/todo/todo_cubit.dart';
// import 'logic/cubit/todo/user/user_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (ctx) => UserCubit(),
          //   ),
          // BlocProvider(
          //     create: (ctx) => TodoCubit(userCubit: ctx.read<UserCubit>()),
          //   ),
          //  BlocProvider(
          //     create: (ctx) => ActivTodosCubit(ctx.read<TodoCubit>()),
          //   ),
          //   BlocProvider(
          //     create: (ctx) => CpmopletedTodosCubit(ctx.read<TodoCubit>()),
          //   ),
             BlocProvider(create: (ctx) => UserBloc()),
             BlocProvider(create: (ctx) => TodoBloc(ctx.read<UserBloc>())),
             BlocProvider(create: (ctx) => ActivTodosBloc(ctx.read<TodoBloc>())),
             BlocProvider(create: (ctx) => CompletedTodosBloc(ctx.read<TodoBloc>())),
        ],
        child: MaterialApp(
          title: 'To Do App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent, // Backgroundni shaffof qilamiz
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const BackgroundContainer(child: TodoScreen()),
            '/todo-detayls': (context) => const BackgroundContainer(child: TodoDetaylsScreen()),
          }, // SafeArea va Scaffold TodoScreen ichida bo'ladi
        ),
    );
  }
}
// Ilova uchun asosiy fon
class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/application_fon/fon_one.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
