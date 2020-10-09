import 'package:conexao_firebase/dao/task_dao.dart';
import 'package:conexao_firebase/model/task.dart';

class TaskController {
  TaskDao taskDao = TaskDao();
  Future<String> salvar(Task task) {
    if (task.id == null) {
      return taskDao.inserir(task);
    } else {
      return taskDao.alterar(task);
    }
  }

  Future<List<Task>> findAll() async {
    return taskDao.findAll();
  }

  Future<String> excluir(String id) {
    return taskDao.excluir(id);
  }
}
