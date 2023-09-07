part of 'get_data_bloc.dart';

@immutable
abstract class GetDataState {}

class LoadingState extends GetDataState {}
class LoadedTodosState extends GetDataState{
  final List<Todo>todos;

  LoadedTodosState(this.todos);
  List<Object> get props => [todos];

}

class LoadedUsersState extends GetDataState{
  final List<User>users;

  LoadedUsersState(this.users);
  List<Object> get props => [users];

}

class ErrorState extends GetDataState{
  final String message;

  ErrorState(this.message);
  List<Object> get props => [message];
}