part of 'get_data_bloc.dart';

@immutable
abstract class GetDataEvent {}

class GetUsersDataEvent extends GetDataEvent{}
class GetTodosDataEvent extends GetDataEvent{}

