import 'package:fatihs_second_project/services/calculator.dart';
import 'package:fatihs_second_project/views/books_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_book_view_model.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({super.key});

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  TextEditingController _bookCtr = TextEditingController();
  TextEditingController _authorCtr = TextEditingController();
  TextEditingController _dateCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookViewModel>(
      create: (context)=>AddBookViewModel(),
      builder:(context,child)=> Scaffold(
        appBar: AppBar(title: Text('Kitap Ekle'),),
        body: Center(
          child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
            TextFormField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Bu alan boş bırakılamaz';
                }else {
                  return null;
                }
              },
              controller: _bookCtr,
              decoration: InputDecoration(
                hintText: 'Kitap Adı',
                icon: Icon(Icons.book),
              ),
            ),
            TextFormField(
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Bu alan boş bırakılamaz';
                }else {
                  return null;
                }
              },
              controller: _authorCtr,
              decoration: InputDecoration(
                hintText: 'Yazar Adı',
                icon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              onTap: ()async{
                selectedDate=await showDatePicker(context: context, firstDate: DateTime(1999), lastDate: DateTime.now(),initialDate: DateTime.now());
                 _dateCtr.text =Calculator.dateTimeToString(selectedDate);
                },
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Bu alan boş bırakılamaz';
                }else {
                  return null;
                }
              },
              controller: _dateCtr,
              decoration: InputDecoration(
                hintText: 'Basım Tarihi',
                icon: Icon(Icons.date_range)
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
               Provider.of<AddBookViewModel>(context,listen: false).addBook(bookName:_bookCtr.text, authorName: _authorCtr.text, publishDate: selectedDate);

              Navigator.pop(context);
              }
            }, child: Text('Ekle')),
          ],)),
        ),
      ),
    );
  }
}
