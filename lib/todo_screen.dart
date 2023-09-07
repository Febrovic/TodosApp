import 'package:flutter/material.dart';
import 'package:todos/bloc/get_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data_model.dart';
import 'users_screens.dart';

class TodosScreen extends StatelessWidget {
  final int selectedUserId;
  TodosScreen({required this.selectedUserId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetDataBloc(TodosApi(), UsersApi())..add(GetTodosDataEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF142A39),
          appBar: AppBar(
            title: const Text('Todos Today'),
            backgroundColor: const Color(0xFF224460),
          ),
          body: BlocBuilder<GetDataBloc, GetDataState>(
            builder: (context, state) {
              if (state is LoadedTodosState) {
                return TodoListView(selectedUserId: selectedUserId);
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
/// Extracted ListView For All Todos
class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    required this.selectedUserId,
  });

  final int selectedUserId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TodosApi().getTodos(selectedUserId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: double.infinity,
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                        color: Color(0xFF224460),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              snapshot.data[index].title,
                              style: kTextStyle,
                            )),
                            Text(
                              snapshot.data[index].completed
                                  ? "Completed"
                                  : "Not Completed",
                              style: kTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
