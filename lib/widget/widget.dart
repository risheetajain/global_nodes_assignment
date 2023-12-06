import 'package:flutter/material.dart';

class Widgets {
  static Widget buildButton(
      {required String title, required Function() onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
    );
  }

  static areYouSureDialogBox(
      {required BuildContext context, required Function() onSuccess}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("Are You sure?"),
          content: const Text("Are you sure want to delete?"),
          actions: [
            ElevatedButton(onPressed: onSuccess, child: const Text("OK")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")),
          ],
        );
      },
    );
  }
}
