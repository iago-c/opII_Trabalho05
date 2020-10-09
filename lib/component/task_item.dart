import 'package:conexao_firebase/view/cadastro_task.dart';
import 'package:conexao_firebase/view/lista_task.dart';
import 'package:flutter/material.dart';
import 'package:conexao_firebase/controller/task_controller.dart';
import 'package:conexao_firebase/model/task.dart';

class TaskItem extends StatefulWidget {
  Task _task;
  List<Task> _listTasks;
  int _index;
  TaskItem(this._task, this._listTasks, this._index);
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Task _ultimoRemovido;
  TaskController _taskController = TaskController();
  _atualizarLista() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListaTask(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
          color: Colors.blue,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    widget._task.name,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroTask(
                          task: widget._listTasks[widget._index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Checkbox(
                  value: widget._task.done,
                  onChanged: (bool newValue) {
                    setState(() {
                      widget._task.done = newValue;
                      _taskController.salvar(widget._task);
                    });
                  })
            ],
          )),
      onDismissed: (direction) {
        setState(() {
          mostrarAlerta(context);
        });
      },
    );
  }

  mostrarAlerta(BuildContext context) {
    Widget botaoNao = FlatButton(
      child: Text(
        "Não",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _atualizarLista();
      },
    );
    Widget botaoSim = FlatButton(
      child: Text(
        "Sim",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _ultimoRemovido = widget._listTasks[widget._index];
        widget._listTasks.removeAt(widget._index);
        _taskController.excluir(_ultimoRemovido.id);
        _atualizarLista();
      },
    );
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.blue,
      title: Text(
        "Aviso",
        style: TextStyle(color: Colors.black),
      ),
      content: Text(
        "Deseja apagar o registro?",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        botaoNao,
        botaoSim,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
