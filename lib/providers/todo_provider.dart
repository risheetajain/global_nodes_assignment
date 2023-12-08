import 'package:flutter/material.dart';
import 'package:global_nodes_assignment/apis/firebase_firestore.dart';
import 'package:global_nodes_assignment/constants/constant.dart';
import 'package:global_nodes_assignment/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> get allTodoList {
    return _allTodoList;
  }

  List<TodoModel> _allTodoList = [];

  addTodo({required String taskname, required String taskDescription}) {
    var uuid = const Uuid();
    String id = uuid.v1();
    Map<String, dynamic> addTodo = {
      "currentDate": DateTime.now().toString(),
      "taskName": taskname,
      "taskDescription": taskDescription,
      "status": TaskStatus.pending.name.toString(),
      "id": id
    };
    _allTodoList.add(TodoModel.fromJson(addTodo));
    FirestoreAPI().addTodoData(todoData: addTodo, id: id);

    notifyListeners();
  }

  updateTodo(
      {required String id, required TodoModel todos, required int index}) {
    _allTodoList[index] = todos;
    FirestoreAPI().updateTodoData(id: id, todoData: todos.toJson());

    notifyListeners();
  }

  deleteTodo({required String id, required int index}) {
    FirestoreAPI().deleteTodoData(id: id);
    _allTodoList.removeAt(index);
    notifyListeners();
  }

  updateStatusTodo({required String id, required TaskStatus status}) {
    FirestoreAPI()
        .updateTodoData(todoData: {"status": status.name.toString()}, id: id);
    notifyListeners();
  }

  getListofTodo() async {
    final myTodosFir = await FirestoreAPI().getTodosData();

    for (var element in myTodosFir) {
      _allTodoList
          .add(TodoModel.fromJson(element.data() as Map<String, dynamic>));
    }

    notifyListeners();
  }

  clearProviderData() {
    _allTodoList = [];
    notifyListeners();
  }
}
