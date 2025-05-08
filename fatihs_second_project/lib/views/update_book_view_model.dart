import 'package:fatihs_second_project/services/calculator.dart';
import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../services/database.dart';

class UpdateBookViewModel extends ChangeNotifier {
  Database _database = Database();

  Future<void> updateBook ({required String bookName, required String authorName, required DateTime publishDate, required Book book}) async{
    Book updateBook = Book(id: book.id, bookName: bookName, authorName: authorName, publishDate:Calculator.dateTimeToTimestamp(publishDate), borrows: []);
    await _database.setBook(collectionPath: 'books', bookAsMap: updateBook);
  }
}

