import 'package:fatihs_second_project/model/book_model.dart';
import 'package:fatihs_second_project/services/calculator.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class AddBookViewModel extends ChangeNotifier {
  Database _database = Database();
  
 Future<void> addBook ({required String bookName,required String authorName,required DateTime publishDate}) async{
   Book newBook = Book(id: DateTime.now().toIso8601String(), bookName: bookName, authorName: authorName, publishDate: Calculator.dateTimeToTimestamp(publishDate), borrows: []);
   
   await _database.setBook(collectionPath: 'books', bookAsMap: newBook);
 } 
}