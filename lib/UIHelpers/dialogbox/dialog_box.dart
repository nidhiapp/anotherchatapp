import 'package:flutter/material.dart';

class DeleteDialogBox extends StatelessWidget {
  const DeleteDialogBox(
      {super.key,
      this.isDeleteForAll = false,
      this.deleteForAll,
      this.deleteForMe});
  final bool isDeleteForAll;
  final VoidCallback? deleteForMe, deleteForAll;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("deleteMessage"),
      actions: [
        InkWell(
            onTap: () {
              deleteForMe!();
              Navigator.pop(context);
            },
            child: const Text("deleteForMe")),
        if (isDeleteForAll)
          InkWell(
              onTap: () {
                deleteForAll!();
                Navigator.pop(context);
              },
              child: const Text("deleteForEveryone"))
      ],
    );
  }
}
