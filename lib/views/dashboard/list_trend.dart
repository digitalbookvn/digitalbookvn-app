import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/dashboard/item_book.dart';
import 'package:arbook/views/list/list_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

// final title = 'Xu hướng';

class ListTrend extends StatefulWidget {
  const ListTrend({Key? key}) : super(key: key);

  @override
  ListTrendState createState() => ListTrendState();
}

class ListTrendState extends State<ListTrend> {
  final List<ArBook> _list=[];
  @override
  void initState() {
    super.initState();
    _callAPI();
  }

  void _callAPI() async {
    final Response response = await API.get({},
        'http://arbook.vietpix.com/arbook/api/books/list?pageNumber=3&pageSize=10'
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
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 22),
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
                          title: FlutterI18n.translate(
                              context, 'dashboard.trending'),
                          filter: {})));
            },
            child: Text(
              FlutterI18n.translate(context, 'dashboard.trending'),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
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
