import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial(User(id: '1', name:'Azamjon')));

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
  }

 User get currentUser{
    return state.user!;
  }

}
