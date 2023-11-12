import 'package:flutter/material.dart';
import 'package:rest_api_crud/pages/todo_list_page.dart';
import 'package:rest_api_crud/utils/network_manager.dart';
import 'package:rest_api_crud/widgets/item_widget.dart';

import '../models/todo_item.dart';

class TodoDonePage extends StatefulWidget {
  const TodoDonePage({super.key});

  @override
  State<TodoDonePage> createState() => _TodoDonePageState();
}

class _TodoDonePageState extends State<TodoDonePage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodosIsDone(true).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Todos Is Done"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todo yang sudah diselesaikan",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todoItem = todos[index];
                return ItemWidget(
                  todoItem: todoItem,
                  handleRefresh: () {},
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TodoListPage();
          },));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
