import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/Model/Todo_model.dart';

class DatabaseService {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todos");
  User? user = FirebaseAuth.instance.currentUser;

  // Add a new todo item
  Future<DocumentReference> addTodoItem(String title, String description) async {
    return await todoCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update a todo task
  Future<void> updateTodo(String id, String title, String description) async {
    final updateTodoCollection = todoCollection.doc(id);
    return await updateTodoCollection.update({
      'title': title,
      'description': description,
    });
  }

  // Update the status of a todo task
  Future<void> updateTodoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({'completed': completed});
  }

  // Delete a todo task
  Future<void> deleteTodoTask(String id) async {
    return await todoCollection.doc(id).delete();
  }

  // Get pending tasks
  Stream<List<Todo>> get todos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  // Get completed tasks
  Stream<List<Todo>> get completedTodos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? false,
        timestamp: doc['createdAt'] ?? '',
      );
    }).toList();
  }
}
