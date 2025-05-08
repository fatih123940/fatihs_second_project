import 'package:fatihs_second_project/services/calculator.dart';
import 'package:fatihs_second_project/views/update_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/book_model.dart';

class UpdateBookView extends StatefulWidget {
  Book book;
  UpdateBookView({super.key,required this.book});

  @override
  State<UpdateBookView> createState() => _UpdateBookViewState();
}

class _UpdateBookViewState extends State<UpdateBookView> {
  TextEditingController kitapCtr = TextEditingController();
  TextEditingController yazarCtr = TextEditingController();
  TextEditingController tarihCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    kitapCtr.text=widget.book.bookName;
    yazarCtr.text=widget.book.authorName;
    tarihCtr.text=Calculator.dateTimeToString(Calculator.timestampToDateTime(widget.book.publishDate));
    return ChangeNotifierProvider<UpdateBookViewModel>(
      create: (context)=>UpdateBookViewModel(),
      builder:(context,child)=> Scaffold(
        appBar: AppBar(title: Text('Kitap Güncelle'),),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Lütfen kitap adı giriniz';
                        }else {
                          return null;
                        }
                      },
                      controller: kitapCtr,
                      decoration: InputDecoration(
                        hintText: 'Kitap adı',
                        icon: Icon(Icons.book),
                      ),
                    ),
                    TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Lütfen yazar adı giriniz';
                        }else {
                          return null;
                        }
                      },
                      controller: yazarCtr,
                      decoration: InputDecoration(
                        hintText: 'Yazar Adı',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      onTap: ()async{
                        selectedDate= await showDatePicker(context: context, firstDate: DateTime(1999), lastDate: DateTime.now(),initialDate: DateTime.now());

                      },
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Bu alan boş bırakılamaz';
                        }else {
                          return null;
                        }
                      },
                      controller: tarihCtr,
                      decoration: InputDecoration(
                        hintText: 'Basım Tarihi',
                        icon: Icon(Icons.date_range),
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                        Provider.of<UpdateBookViewModel>(context,listen: false).updateBook(bookName: kitapCtr.text, authorName: yazarCtr.text, publishDate: selectedDate ?? Calculator.timestampToDateTime(widget.book.publishDate), book:widget.book );
                        Navigator.pop(context);
                      }
                    }, child: Text('Güncelle'))
                  ],)),
          ),
        ),
      ),
    );
  }
}

