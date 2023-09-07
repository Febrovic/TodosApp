import 'dart:async';
import 'package:todos/users_screens.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data_model.dart';

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  final TodosApi todosApi;
  final UsersApi usersApi;
  GetDataBloc(this.todosApi,this.usersApi) : super(LoadingState()) {
    on<GetDataEvent>((event, emit) async{
      if(event is GetTodosDataEvent){
        emit(LoadingState());
        try {
          final todos = await todosApi.getTodos(selectedUser);
          emit(
            LoadedTodosState(todos),
          );
        }catch (e) {
          emit(ErrorState("Error Loading Todos"));
        }
      }

      if(event is GetUsersDataEvent){
        emit(LoadingState());
        try {
          final users = await usersApi.getUsers();
          emit(
            LoadedUsersState(users),
          );
        }catch (e) {
          emit(ErrorState("Error Loading Todos"));
        }
      }


    });
  }
}
