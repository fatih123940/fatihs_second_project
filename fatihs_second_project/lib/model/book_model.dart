import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatihs_second_project/model/borrow_model.dart';

class Book {
  String id;
  String bookName;
  String authorName;
  Timestamp publishDate;
  List<Borrow> borrows;

  Book({required this.id,required this.bookName,required this.authorName,required this.publishDate,required this.borrows});



  Map<String,dynamic> toMap () {
    List<Map<String,dynamic>> borrows = this.borrows.map((borrow)=>borrow.toMap()).toList();
    return {'id': id,
      'bookName': bookName,
      'authorName': authorName,
      'publishDate': publishDate,
      'borrows':borrows,
    };
  }
  factory  Book.fromMap (Map map) {
    
    var borrowListAsMap = map['borrows'] as List;
    
    List<Borrow> borrows = borrowListAsMap.map((borrowAsMap)=>Borrow.fromMap(borrowAsMap)).toList();

    return  Book(id: map['id'],
        bookName: map['bookName'],
        authorName: map['authorName'],
        publishDate: map['publishDate'],
        borrows:borrows,

    );
  }


}