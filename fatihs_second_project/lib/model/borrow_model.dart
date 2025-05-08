import 'package:cloud_firestore/cloud_firestore.dart';

class Borrow {
  String name;
  String surname;
  String photoUrl;
  Timestamp borrowDate;
  Timestamp returnDate;

  Borrow({required this.name,required this.surname,required this.photoUrl,required this.borrowDate,required this.returnDate,});




Map<String,dynamic> toMap () =>{

    'name': name,
     'surname': surname,
     'photoUrl': photoUrl,
     'borrowDate': borrowDate,
     'returnDate': returnDate,


};

factory Borrow.fromMap(Map map) =>
    Borrow(name: map['name'],
      surname: map['surname'],
      photoUrl: map['photoUrl'],
      borrowDate: map['borrowDate'],
      returnDate: map['returnDate'],
      );
}


