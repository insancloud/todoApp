import 'package:flutter/material.dart';
import 'package:rest_api_crud/utils/network_manager.dart';

import '../models/todo_item.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Tambah TodoList"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: taskController,
                decoration: const InputDecoration(hintText: "Task"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tidak boleh Kosong yaa";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(hintText: "Description"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi diisi Dulu yaa :D";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  final item = TodoItem(
                      task: taskController.text,
                      description: descController.text,
                      isDone: false);

                  if (item.task.isNotEmpty && item.description.isNotEmpty) {
                    await NetworkManager().postData(item);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
