import 'package:conexao_firebase/component/cria_textfield.dart';
import 'package:conexao_firebase/controller/task_controller.dart';
import 'package:conexao_firebase/model/task.dart';
import 'package:conexao_firebase/util/hex_color.dart';
import 'package:flutter/material.dart';

import 'lista_task.dart';

class CadastroTask extends StatefulWidget {
  final Task task;
  CadastroTask({this.task});
  @override
  _CadastroTaskState createState() => _CadastroTaskState();
}

class _CadastroTaskState extends State<CadastroTask> {
  TaskController _taskController = TaskController();
  String _id;
  TextEditingController _nameController = TextEditingController();
  bool _doneStatus = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _salvar(BuildContext context) {
    Task task = Task(_nameController.text, _doneStatus, id: _id);
    setState(() {
      _taskController.salvar(task).then((res) {
        setState(() {
          //_displaySnackBar(context, res.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaTask()),
          );
        });
      });
    });
  }

  @override
  void initState() {
    if (widget.task != null) {
      _id = widget.task.id;
      _nameController.text = widget.task.name;
      _doneStatus = widget.task.done;
    } else {
      _id = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("282A36"),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de Tarefa"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaTask()),
              );
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  criaTextField("Tarefa", _nameController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton.icon(
                  onPressed: () {
                    _salvar(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.green,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
