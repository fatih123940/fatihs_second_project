import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../services/database.dart';

class BooksViewModel extends ChangeNotifier {
  Database _database = Database();

  Stream<List<Book>> getBookList() {
   Stream<List<DocumentSnapshot>> streamListDocument =  _database.getBookListFromApi('books').map((querySnapshot)=>querySnapshot.docs);

  Stream<List<Book>> streamListBook =  streamListDocument.map((listOfDocSnap)=>listOfDocSnap.map((docSnap)=>Book.fromMap(docSnap.data() as Map)).toList());
return streamListBook;
   }
   Future<void> deleteBook (Book book) async{
    await _database.deleteDocuemnt(collectionPath: 'books', id:book.id);
   }

}