import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/dashboard/item_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  CollectionState createState() => CollectionState();
}

class CollectionState extends State<Collection>
    with AutomaticKeepAliveClientMixin {
  final List<ArBook> _list = [];

  int pageSize = 12;
  int pageNumber = 1;

  int totalCount = 0;

  bool isLoading = false;
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _callAPI();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_list.length < totalCount) {
        setState(() {
          debugPrint("comes to bottom $isLoading");
          isLoading = true;

          if (isLoading) {
            debugPrint("RUNNING LOAD MORE");

            pageNumber = pageNumber + 1;

            _callAPI();
            isLoading = false;
          }
        });
      }
    }
  }

  void _callAPI() async {
    final Response response = await API.get({},
        '$urlBase/arbook/api/books/list?pageNumber=$pageNumber&pageSize=$pageSize');
    setState(() {
      var list = (response.items)
          .map((dictionary) => ArBook.fromJson(dictionary))
          .toList();
      _list.addAll(list);
      totalCount = response.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(right: 22, left: 22),
              height: 50,
              // color: Theme.of(context).colorScheme.secondary,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FlutterI18n.translate(context, 'collection.title'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              )),
          GridView.builder(
            // controller: _scrollController,
            itemCount: _list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.5,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),

            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            // crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            itemBuilder: (context, index) => ItemBook(book: _list[index]),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
