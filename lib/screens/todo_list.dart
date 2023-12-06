import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:global_nodes_assignment/constants/constant.dart';
import 'package:global_nodes_assignment/constants/decoration.dart';
import 'package:global_nodes_assignment/widget/widget.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController descCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            DropdownButtonFormField(
                decoration:
                    textFieldDecoration.copyWith(labelText: "Filter Options"),
                items: List.generate(filterOptionsList.length, (index) {
                  return DropdownMenuItem(
                      value: filterOptionsList[index],
                      child: Text(filterOptionsList[index].toString()));
                }),
                onChanged: (val) {}),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: const Text("Add Data"),
                    leading: Checkbox(value: true, onChanged: (val) {}),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showAdaptiveDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("Edit Todo Data"),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.close))
                                        ],
                                      ),
                                      actions: [
                                        TextFormField(
                                          decoration:
                                              textFieldDecoration.copyWith(
                                                  hintText: "Task Name",
                                                  labelText: "Task Name"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: TextFormField(
                                            decoration:
                                                textFieldDecoration.copyWith(
                                                    hintText:
                                                        "Task Description",
                                                    labelText:
                                                        "Task Description"),
                                          ),
                                        ),
                                        Widgets.buildButton(
                                            title: "Edit Task", onTap: () {})
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              Widgets.areYouSureDialogBox(
                                  context: context, onSuccess: () {});
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                    subtitle: const Text("Its Description"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text("Add Todo Data"),
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
                      Widgets.buildButton(title: "Add Task", onTap: () {})
                    ],
                  ),
                );
              });
        },
        label: const Text("Add Task"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
