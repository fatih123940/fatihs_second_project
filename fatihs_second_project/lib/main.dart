import 'package:fatihs_second_project/views/books_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseFirestoreApp());
}

class FirebaseFirestoreApp extends StatelessWidget {
  const FirebaseFirestoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksView(),
    );
  }
}
