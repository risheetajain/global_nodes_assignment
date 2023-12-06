import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_nodes_assignment/constants/collection.dart';

class FirestoreAPI {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  getData() {
    firestoreInstance.collection(CollectionConst.todoCollection);
  }
  
}
