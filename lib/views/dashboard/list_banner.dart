import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arbook/models/advert.dart';

// import 'package:arbook/models/response.dart';
// import 'package:arbook/services/api.dart';

import 'item_banner.dart';

class ListBanner extends StatefulWidget {
  const ListBanner({Key? key}) : super(key: key);

  @override
  ListBannerState createState() => ListBannerState();
}

class ListBannerState extends State<ListBanner> {
  List<ArBook> _list = [];

  @override
  void initState() {

    super.initState();
    _callAPI();

  }

  void _callAPI() async {
    final Response response = await API.get({},
        // '$urlBase/Tour3d/GetByPageID?lang=vi&pageSize=${this.pageSize}&pageId=${this.pageId}'
        'http://arbook.vietpix.com/arbook/api/books/advert'
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
    //

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 6, right: 6),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemBanner(book: _list[index]);
        },
      ),
    );
  }
}
