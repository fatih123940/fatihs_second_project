import 'package:fatihs_second_project/services/calculator.dart';
import 'package:fatihs_second_project/views/borrow_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/book_model.dart';
import '../model/borrow_model.dart';

class BarrowListView extends StatefulWidget {
  Book book;
   BarrowListView({super.key,required this.book});

  @override
  State<BarrowListView> createState() => _BarrowListViewState();
}

class _BarrowListViewState extends State<BarrowListView> {
  @override
  Widget build(BuildContext context) {
    List<Borrow> borrowList = widget.book.borrows;
    return ChangeNotifierProvider<BorrowListViewModel>(
      create: (context)=>BorrowListViewModel(),
      builder:(context,child)=> Scaffold(
        appBar: AppBar(title: Text('${widget.book.bookName} Ödünç Kayıtlar'),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.separated(separatorBuilder:(context,_) =>Divider(),itemCount:widget.book.borrows.length,itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.yellow,
                  ),
                  title: Text(widget.book.borrows[index].name + ' ' + widget.book.borrows[index].surname),
                );
              }),
            ),
            InkWell(
              onTap: ()async{
               Borrow? newBorrow = await showModalBottomSheet<Borrow>(context: context, builder: (context){
                  return BorrowForm();
                });
               if(newBorrow != null){
                 setState(() {
                   borrowList.add(newBorrow);
                 });
                 Provider.of<BorrowListViewModel>(context,listen: false).updateBook(borrowList: borrowList, book: widget.book);
               }
              },
              child: Container(
                alignment: Alignment.center,
                height: 80,
                color: Colors.blueAccent,
                child: Text('YENİ ÖDÜNÇ',style: TextStyle(color: Colors.white,fontSize: 18),),

              ),
            ),
          ],
        ),

      ),
    );
  }
}

class BorrowForm extends StatefulWidget {
  const BorrowForm({
    super.key,
  });

  @override
  State<BorrowForm> createState() => _BorrowFormState();
}

class _BorrowFormState extends State<BorrowForm> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController borrowDateCtr = TextEditingController();
  TextEditingController returnDateCtr = TextEditingController();
  late DateTime _selectedBorrowDate;
  late DateTime _selectedReturnDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameCtr.dispose();
    surnameCtr.dispose();
    borrowDateCtr.dispose();
    returnDateCtr.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
          key: _formKey,
          child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.yellow,
                  ),
                  Positioned(
                      bottom: -5,
                      right: -10,
                      child: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined)))
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Lütfen isim giriniz';
                      }else {
                        return null;
                      }
                    },
                    controller: nameCtr,
                    decoration: InputDecoration(
                    hintText: 'Ad',
                  ),),
                  TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return 'Lütfen soyisim giriniz';
                      }else {
                        return null;
                      }
                    },
                    controller: surnameCtr,
                    decoration: InputDecoration(
                      hintText: 'Soyad',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return 'Lütfen tarih giriniz';
                  }else {
                    return null;
                  }
                },
                controller: borrowDateCtr,
                onTap: ()async{
                  _selectedBorrowDate=(await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)),initialDate: DateTime.now()))!;

                  borrowDateCtr.text=Calculator.dateTimeToString(_selectedBorrowDate);

                  },
                decoration: InputDecoration(
                  hintText: 'Alım Tarihi',
                ),
              ),
            ),
            Flexible(
              child: TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Lütfen tarih giriniz';
                  }else {
                    return null;
                  }
                },
                controller: returnDateCtr,
                onTap: ()async{
                  _selectedReturnDate=(await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)),initialDate: DateTime.now()))!;

                  returnDateCtr.text =Calculator.dateTimeToString(_selectedReturnDate);
                  },
                decoration: InputDecoration(
                  hintText: 'İade Tarihi',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            Borrow newBorrow = Borrow(name: nameCtr.text, surname: surnameCtr.text, photoUrl: 'www', borrowDate: Calculator.dateTimeToTimestamp(_selectedBorrowDate), returnDate: Calculator.dateTimeToTimestamp(_selectedReturnDate));
            Navigator.pop(context,newBorrow);


          }
        }, child: Text('YENİ ÖDÜNÇ KAYIT EKLE',style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),),
      ],)),
    );
  }
}



