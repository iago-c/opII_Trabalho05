import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexao_firebase/model/task.dart';

class TaskDao {
  final databaseReference = FirebaseFirestore.instance;
  final String colecao = "tasks";

  Future<String> inserir(Task task) async {
    try {
      DocumentReference ref =
          await databaseReference.collection(colecao).add(task.toMap());
      return ref.id;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> alterar(Task task) async {
    try {
      await databaseReference
          .collection(colecao)
          .doc(task.id)
          .update(task.toMap());
      return "Registro atualizado.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Task>> findAll() async {
    QuerySnapshot tasks = await databaseReference.collection(colecao).get();
    List<Task> listTasks = List();
    tasks.docs.forEach((elemento) {
      listTasks.add(Task.fromJson(elemento.data(), elemento.id));
    });
    return listTasks;
  }

  Future<String> excluir(String id) async {
    try {
      await databaseReference.collection(colecao).doc(id).delete();
      return "Registro excluído com sucesso.";
    } catch (e) {
      return e.toString();
    }
  }
}
