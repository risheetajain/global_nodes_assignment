import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_nodes_assignment/apis/firebase_auth_api.dart';

class FirestoreAPI {
  final todoCollRef = FirebaseFirestore.instance
      .collection(FirebaseAuthenication.getCurrentUser().uid);

  Future<List<QueryDocumentSnapshot>> getTodosData() async {
    final todoData = await todoCollRef.get();
    return todoData.docs;
  }

  addTodoData({required Map<String, dynamic> todoData, required String id}) {
    return todoCollRef.doc(id).set(todoData);
  }

  updateTodoData({required Map<String, dynamic> todoData, required String id}) {
    return todoCollRef.doc(id).update(todoData);
  }

  deleteTodoData({required String id}) {
    return todoCollRef.doc(id).delete();
  }
}
