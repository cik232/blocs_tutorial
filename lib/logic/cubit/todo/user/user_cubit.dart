import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial_todo_app/data/models/user.dart';
import 'package:meta/meta.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(User(id: '1', name:'Azamjon')));

  User get currentUser{
    return state.user!;
  }
}
