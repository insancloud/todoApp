// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";

import "package:rest_api_crud/utils/network_manager.dart";

import "../models/todo_item.dart";

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.todoItem,
    required this.handleRefresh,
  }) : super(key: key);
  final TodoItem todoItem;
  final Function() handleRefresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoItem.isDone ? Colors.greenAccent : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoItem.task),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(todoItem.description),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  await NetworkManager().updateData(
                    todoItem.copyWith(isDone: true),
                  );
                  handleRefresh();
                },
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            const SizedBox(
              width: 8,
            ),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  await NetworkManager().deleteData(todoItem);
                  handleRefresh();
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}
