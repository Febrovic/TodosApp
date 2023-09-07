import 'dart:convert';
import 'package:http/http.dart' as http;


class User {
  final int id;
  final String name;
  final String username;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });
}
class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });
}
class UsersApi{
  Future<List<User>> getUsers() async {
    var userData =
    await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var jsonData = json.decode(userData.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(
          id: u["id"],
          username: u["username"],
          email: u["email"],
          name: u["name"]);
      users.add(user);
    }
    return users;
  }
}


class TodosApi{
  Future<List<Todo>> getTodos(int userId) async {
    var todoData =
    await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users/$userId/todos"));
    var jsonData = json.decode(todoData.body);
    List<Todo> todos = [];
    for (var t in jsonData) {
      Todo todo = Todo(
          id: t["id"],
          userId: t["userId"],
          title: t["title"],
          completed: t["completed"]);
      todos.add(todo);
    }
    return todos;
  }
}

