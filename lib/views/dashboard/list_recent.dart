import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/models/user.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/services/secret.dart';
import 'package:arbook/views/dashboard/item_recent.dart';
import 'package:arbook/views/list/list_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arbook/models/book.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListRecent extends StatefulWidget {
  const ListRecent({Key? key}) : super(key: key);

  @override
  ListRecentState createState() => ListRecentState();
}

class ListRecentState extends State<ListRecent> {
  List<ArBook> books = [];

  String uuid = '';

  @override
  void initState() {
    _callAPI();
    super.initState();
  }

  final _storage = const FlutterSecureStorage();

  Map<String, String> secret = {};

  IOSOptions _getIOSOptions() => const IOSOptions();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> _readAll() async {
    final all = await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    setState(() {
      for (var entry in all.entries) {
        secret[entry.key] = entry.value;
      }
    });
  }

  Future<String> getUserData() async {
    await _readAll();
    String email = secret['email'] ?? '';
    final Response response =
        await API.get({}, '$urlBase/arbook/api/user/profile/$email');
    var user = User.fromJson(response.item);
    return user.id;
  }

  void _callAPI() async {
    var uuid = await getUserData();

    final Response response =
        await API.get({}, '$urlBase/arbook/api/books/viewed/$uuid');
    var list = (response.items)
        .map((dictionary) => ArBook.fromJson(dictionary))
        .toList();

    setState(() {
      books.addAll([list[0], list[1],list[2]]);
      // books.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (books.isNotEmpty)
        ? Container(
            margin: const EdgeInsets.only(top: 30),
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
                                title: FlutterI18n.translate(
                                    context, 'dashboard.recently'),
                                filter: {})));
                  },
                  child: Text(
                    FlutterI18n.translate(context, 'dashboard.recently'),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemRecent(book: books[index]);
                  },
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
