import 'package:fatihs_second_project/views/add_book_view.dart';
import 'package:fatihs_second_project/views/barrow_list_view.dart';
import 'package:fatihs_second_project/views/books_view_model.dart';
import 'package:fatihs_second_project/views/update_book_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/book_model.dart';

class BooksView extends StatefulWidget {
  const BooksView({super.key});

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BooksViewModel>(
      create: (context)=>BooksViewModel(),
      builder:(context,child)=> Scaffold(
        appBar: AppBar(title: Text('Kitaplar Listesi'),),
        body: Center(child: StreamBuilder<List<Book>>(stream: Provider.of<BooksViewModel>(context,listen: false).getBookList(), builder: (context,asyncSnapshot){
          if(asyncSnapshot.hasError){
            return Center(child: Text('Hata'),);
          }else if(!asyncSnapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else {
            List<Book>? kitapList = asyncSnapshot.data;

            return BuildListView(kitapList: kitapList);
          }
        }),),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBookView()));
        },child: Icon(Icons.add),),
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    super.key,
    required this.kitapList,
  });

  final List<Book>? kitapList;

  @override
  State<BuildListView> createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  bool isFiltering = false;
  late List<Book> filteredList;
  @override
  Widget build(BuildContext context) {
    var fullList = widget.kitapList;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query){
            if(query.isNotEmpty){
              isFiltering=true;
              setState(() {
                filteredList= fullList!.where((book){
                  return book.bookName.toLowerCase().contains(query.toLowerCase());
                }).toList();
              });
            }else {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              setState(() {
                isFiltering=false;
              });
            }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              hintText: 'Arama: Kitap Adı',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(child: ListView.builder(itemCount:isFiltering?filteredList.length:widget.kitapList!.length,itemBuilder: (context,index){
          return Dismissible(
            onDismissed: (_){
              Provider.of<BooksViewModel>(context,listen: false).deleteBook(widget.kitapList![index]);
            },
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete,color: Colors.white,),
            ),
            child: Card(
              child: ListTile(
                leading: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BarrowListView(book: widget.kitapList![index])));
                }, icon: Icon(Icons.person)),
                trailing: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateBookView(book: widget.kitapList![index],)));
                }, icon: Icon(Icons.edit)),
                title: Text(isFiltering?filteredList[index].bookName:widget.kitapList![index].bookName),
                subtitle: Text(isFiltering?filteredList[index].authorName:widget.kitapList![index].authorName),
    
              ),
            ),
          );
        })),
      ],
    );
  }
}

