import 'package:flutter/material.dart';
import 'package:rest_api_crud/pages/form_page.dart';
import 'package:rest_api_crud/pages/todo_done_page.dart';
import 'package:rest_api_crud/utils/network_manager.dart';
import 'package:rest_api_crud/widgets/item_widget.dart';

import '../models/todo_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  // func untuk refresh data
  void refreshData() {
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodosIsDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
    });

    NetworkManager().getTodosIsDone(false).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Todo List App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TodoList Item",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const TodoDonePage();
                    },));
                  },
                  child: Text(
                    "Sudah di Selesaikan : $totalDone",
                    style: const TextStyle(
                        // decoration: TextDecoration.underline
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: todos.isEmpty
                        ? const Center(
                            child: Text("Tidak Ada Data!"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemWidget(
                                todoItem: todos[index],
                                handleRefresh: refreshData,
                              );
                            },
                            itemCount: todos.length,
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormPage();
              },
            ),
          );
          refreshData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
