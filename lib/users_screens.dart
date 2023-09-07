import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data_model.dart';
import 'package:todos/todo_screen.dart';
import 'bloc/get_data_bloc.dart';

TextStyle kTextStyle = TextStyle(color: Colors.white);
late int selectedUser;

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetDataBloc(TodosApi(), UsersApi())..add(GetUsersDataEvent()),
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
              if (state is LoadedUsersState) {
                return UserListView();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }


  /// Extracted ListView For All Users
  FutureBuilder<List<User>> UserListView() {
    return FutureBuilder(
                future: UsersApi().getUsers(),
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
                                  onTap: () {
                                    setState(() {
                                      selectedUser = snapshot.data[index].id;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  TodosScreen(
                                                      selectedUserId:
                                                          selectedUser))));
                                    });
                                  },
                                  title: Row(
                                    children: [
                                      Text(
                                        snapshot.data[index].name,
                                        style: kTextStyle,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '(${snapshot.data[index].username})',
                                        style: kTextStyle,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    snapshot.data[index].email,
                                    style: kTextStyle,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
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
