import 'package:conexao_firebase/component/task_item.dart';
import 'package:conexao_firebase/controller/task_controller.dart';
import 'package:conexao_firebase/model/task.dart';
import 'package:conexao_firebase/util/hex_color.dart';
import 'package:flutter/material.dart';

import 'cadastro_task.dart';

class ListaTask extends StatefulWidget {
  @override
  _ListaTaskState createState() => _ListaTaskState();
}

class _ListaTaskState extends State<ListaTask> {
  List<Task> _listaTasks = [];
  TaskController _taskController = TaskController();
  @override
  void initState() {
    super.initState();
    _taskController.findAll().then((dados) {
      setState(() {
        _listaTasks = dados;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("282A36"),
      appBar: AppBar(
        centerTitle: true,
        title: Text("To Do List"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Task>>(
        initialData: _listaTasks,
        future: _taskController.findAll(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(
                      "Carregando...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Task> tasks = snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  final Task task = tasks[index];
                  return TaskItem(task, _listaTasks, index);
                },
                itemCount: tasks.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CadastroTask(),
              ),
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
