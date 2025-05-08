import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../model/borrow_model.dart';
import '../services/database.dart';

class BorrowListViewModel extends ChangeNotifier {
  Database _database = Database();

  Future<void> updateBook ({required List<Borrow> borrowList, required Book book}) async {
    Book newBook = Book(id: book.id, bookName: book.bookName, authorName:book.authorName, publishDate: book.publishDate, borrows: borrowList);
    
    await _database.setBook(collectionPath: 'books', bookAsMap: newBook);
  }
}