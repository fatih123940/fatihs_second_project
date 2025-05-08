

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/book_model.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getBookListFromApi(String collectionPath) {
     return _firestore.collection(collectionPath).snapshots();
  }
  Future<void> deleteDocuemnt ({required String collectionPath,required String id}) async {
    await _firestore.collection(collectionPath).doc(id).delete();
  }
 Future<void> setBook ({required String collectionPath , required Book bookAsMap})async {
    await _firestore.collection(collectionPath).doc(Book.fromMap(bookAsMap.toMap()).id).set(bookAsMap.toMap());
  }
}