import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/dashboard/item_book.dart';
import 'package:arbook/views/list/list_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arbook/models/book.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

// final title = 'Khám phá sách mới';

class ListNew extends StatefulWidget {
  const ListNew({Key? key}) : super(key: key);

  @override
  ListNewState createState() => ListNewState();
}

class ListNewState extends State<ListNew> {
  List<Book> books = [
    Book(
        id: 1,
        ten: '1',
        anh: 'assets/images/book/1.png',
        thoi_luong: '20 phút'),
    Book(
        id: 2,
        ten: '2',
        anh: 'assets/images/book/2.png',
        thoi_luong: '15 phút'),
    Book(
        id: 3,
        ten: '3',
        anh: 'assets/images/book/3.png',
        thoi_luong: '20 phút'),
    Book(
        id: 4, ten: '4', anh: 'assets/images/book/4.png', thoi_luong: '15 phút')
  ];

  final List<ArBook> _list = [];
  // int pageSize = 10;
  // int pageId = 1;
  @override
  void initState() {
    super.initState();
    _callAPI();
  }

  void _callAPI() async {
    final Response response = await API.get({},
        // '$urlBase/Tour3d/GetByPageID?lang=vi&pageSize=${this.pageSize}&pageId=${this.pageId}'
        'http://arbook.vietpix.com/arbook/api/books/list?pageNumber=1&pageSize=5'
    );
    setState(() {
      var list = (response.items)
          .map((dictionary) => ArBook.fromJson(dictionary))
          .toList();
      _list.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("OK");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListBook(
                          title:
                              FlutterI18n.translate(context, 'dashboard.new'),
                          filter: {})));
            },
            child: Text(
              FlutterI18n.translate(context, 'dashboard.new'),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    ItemBook(book: _list[index]),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
