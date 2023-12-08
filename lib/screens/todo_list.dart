import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:global_nodes_assignment/apis/firebase_auth_api.dart';
import 'package:global_nodes_assignment/apis/shared_preferences.dart';
import 'package:global_nodes_assignment/constants/constant.dart';
import 'package:global_nodes_assignment/constants/decoration.dart';
import 'package:global_nodes_assignment/models/todo_model.dart';
import 'package:global_nodes_assignment/providers/todo_provider.dart';
import 'package:global_nodes_assignment/routes/routes_constant.dart';
import 'package:global_nodes_assignment/widget/widget.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController descCont = TextEditingController();
  String filteroptions = "all";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<TodoProvider>(builder: (context, myToDoProvider, child) {
      List providerTodoListFilter = myToDoProvider.allTodoList.where((todo) {
        switch (filteroptions) {
          case "pending":
            return todo.status == "pending";
          case "completed":
            return todo.status == "completed";
          case "all":
            return true;
          default:
            return true;
        }
      }).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Todo List"),
          actions: [
            IconButton(
                onPressed: () {
                  Widgets.areYouSureDialogBox(
                      context: context,
                      onSuccess: () {
                        SharedPref.clearData();
                        FirebaseAuthenication.logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, RoutesConstant.splashScreen, (route) {
                          return false;
                        });
                        myToDoProvider.clearProviderData();
                      },
                      keyword: "Logout");
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              DropdownButtonFormField(
                  decoration: textFieldDecoration.copyWith(
                      labelText: "Filter Options",
                      hintText: "Filter Your Todo"),
                  items: List.generate(filterOptionsList.length, (index) {
                    return DropdownMenuItem(
                        value: filterOptionsList[index],
                        child: Text(filterOptionsList[index].toString()));
                  }),
                  onChanged: (val) {
                    setState(() {
                      filteroptions = val.toString();
                    });
                  }),
              Expanded(
                child: providerTodoListFilter.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/no_data.webp",
                            height: size.height * 0.3,
                          ),
                          const Center(
                            child: Text(
                              "No Tasks yet! You can add it from below button",
                              textAlign: TextAlign.center,
                              style: largeTitle,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: providerTodoListFilter.length,
                        itemBuilder: (BuildContext context, int index) {
                          TodoModel myTodo = providerTodoListFilter[index];
                          return ListTile(
                            title: Text(
                              myTodo.taskName ?? "",
                              style: TextStyle(
                                  fontSize: 22,
                                  decoration:
                                      myTodo.status == TaskStatus.completed.name
                                          ? TextDecoration.lineThrough
                                          : null),
                            ),
                            leading: Checkbox(
                                value:
                                    myTodo.status == TaskStatus.completed.name,
                                onChanged: (val) {
                                  myTodo.status = val ?? false
                                      ? TaskStatus.completed.name
                                      : TaskStatus.pending.name;

                                  myToDoProvider.updateStatusTodo(
                                      id: myTodo.id.toString(),
                                      status: val ?? false
                                          ? TaskStatus.completed
                                          : TaskStatus.pending);

                                  setState(() {});
                                }),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      getDataAddedOREdit(
                                          isEdit: true,
                                          myToDoProvider: myToDoProvider,
                                          index: index,
                                          myTodo: myTodo);
                                      nameCont.text = myTodo.taskName ?? "";
                                      descCont.text =
                                          myTodo.taskDescription ?? "";
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      Widgets.areYouSureDialogBox(
                                          keyword: "delete",
                                          context: context,
                                          onSuccess: () {
                                            myToDoProvider.deleteTodo(
                                                index: index,
                                                id: myTodo.id.toString());
                                            Navigator.pop(context);
                                          });
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                            subtitle: Text(
                              myTodo.taskDescription ?? "",
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration:
                                      myTodo.status == TaskStatus.completed.name
                                          ? TextDecoration.lineThrough
                                          : null),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            getDataAddedOREdit(isEdit: false, myToDoProvider: myToDoProvider);
          },
          label: const Text("Add Task"),
          icon: const Icon(Icons.add),
        ),
      );
    });
  }

  getDataAddedOREdit(
      {required bool isEdit,
      int? index,
      TodoModel? myTodo,
      required TodoProvider myToDoProvider}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit ? "Edit My Todo" : "Add Todo Data",
                      style: largeTitle,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                TextFormField(
                  controller: nameCont,
                  decoration: textFieldDecoration.copyWith(
                      hintText: "Task Name", labelText: "Task Name"),
                ),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextFormField(
                    controller: descCont,
                    decoration: textFieldDecoration.copyWith(
                        hintText: "Task Description",
                        labelText: "Task Description"),
                  ),
                ),
                Widgets.buildButton(
                    title: isEdit ? "Edit Task" : "Add Task",
                    onTap: () {
                      if (isEdit) {
                        myTodo!.taskName = nameCont.text;
                        myTodo.taskDescription = descCont.text;
                        myToDoProvider.updateTodo(
                            index: index!, id: myTodo.id ?? "", todos: myTodo);
                      } else {
                        myToDoProvider.addTodo(
                            taskname: nameCont.text,
                            taskDescription: descCont.text);
                      }
                      nameCont.clear();
                      descCont.clear();
                      Navigator.pop(context);
                    })
              ],
            ),
          );
        });
  }
}
