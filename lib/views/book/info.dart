import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/book/read.dart';
import 'package:arbook/views/book/simple_screen.dart';
import 'package:arbook/views/book/video.dart';
import 'package:arbook/views/dashboard/item_book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookInfo extends StatefulWidget {
  final ArBook book;

  const BookInfo({Key? key, required this.book}) : super(key: key);

  @override
  BookInfoState createState() => BookInfoState();
}

class BookInfoState extends State<BookInfo> {
  String currentLang = "";

  final List<ArBook> _list = [];

  @override
  void initState() {
    _callAPI();
    super.initState();
  }

  void _callAPI() async {
    final Response response = await API.get({},
        'http://arbook.vietpix.com/arbook/api/books/list?pageNumber=1&pageSize=10&category=${widget.book.data['category']}');
    setState(() {
      var list = (response.items)
          .map((dictionary) => ArBook.fromJson(dictionary))
          .toList();
      _list.addAll(list);
      // debugPrint(list[0].data.toString());
    });
  }

  void addReadBook() async {}

  @override
  Widget build(BuildContext context) {
    setState(() {
      currentLang = FlutterI18n.translate(context, 'current_lang');
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: ListView(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(right: 22),
                height: 50,
                color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/back.svg',
                        width: 20,
                        height: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    Row(children: [
                      SvgPicture.asset(
                        'assets/icons/bookmark.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(
                        'assets/icons/more.svg',
                        width: 20,
                        height: 20,
                      ),
                    ]),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                // borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CachedNetworkImage(
                    imageUrl: 'http://arbook.vietpix.com' +
                        widget.book.data["image"][0]["url"],
                    width: 135,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.book.data["title"][currentLang] ??
                        widget.book.data["title"]["vi"],
                    style: TextStyle(
                        fontFamily: FlutterI18n.translate(context, "font"),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF202020)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Lượt đọc",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF707070)),
                              ),
                              Text(
                                widget.book.data["view_count"].toString(),
                                style: const TextStyle(
                                    color: Color(0xFFF97923),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          Column(
                            children: [
                              const Text("Lượt thích",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF707070))),
                              Text(
                                widget.book.data["like_count"].toString(),
                                style: const TextStyle(
                                    color: Color(0xFFF97923),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      height: 50,
                      // color: Colors.red,
                      child: Container(
                        height: 50,
                        transform: Matrix4.translationValues(0.0, 25.0, -10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (widget.book.data["video"].length != 0)
                                ? TextButton.icon(
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22, vertical: 12),
                                        fixedSize: Size.fromWidth(
                                            (MediaQuery.of(context).size.width -
                                                    65) /
                                                2),
                                        backgroundColor:
                                            const Color(0xFF006338),
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Color(0xFF006338),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    onPressed: () {
                                      String url = "http://arbook.vietpix.com" +
                                          (widget.book.data["video"][0]
                                                  ["url"] ??
                                              "");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoScreen(url: url)));
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/3d.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    label: Text(
                                      FlutterI18n.translate(
                                          context, 'book.info.video-play'),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  )
                                : const SizedBox(),
                            // ),
                            // ),
                            const Spacer(),
                            (widget.book.data["game"]?["arbook"] ?? false)
                                ? TextButton.icon(
                                    // style: ButtonStyle(
                                    //   padding:EdgeInsets.symmetric(vertical: 2,h),
                                    //   backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                    // ),
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22, vertical: 12),
                                        backgroundColor:
                                            const Color(0xFF006338),
                                        fixedSize: Size.fromWidth(
                                            (MediaQuery.of(context).size.width -
                                                    65) /
                                                2),
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Color(0xFF006338),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(50))),

                                    onPressed: () {
                                      print("OK");
                                      // if (widget.book.data["game"]["gameId"] ==
                                      //     0) {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => ModelView(
                                      //             id: widget.book
                                      //                 .data["game"]["gameId"]
                                      //                 .toString())));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => ObjectGesturesWidget()));
                                      // } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SimpleScreen(
                                                    gameId: widget.book
                                                        .data["game"]["gameId"]
                                                        .toString(),
                                                    book: widget.book,
                                                  )));
                                      // }
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/3d.svg',
                                      width: 24,
                                      height: 24,
                                      // color: Color(0xFF006338),
                                    ),
                                    label: Text(
                                      FlutterI18n.translate(
                                          context, 'book.info.play-game'),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            // Container(color: Theme.of(context).colorScheme.primary,height: 50,),
            Container(
              margin: const EdgeInsets.only(top: 45),
              padding: const EdgeInsets.only(left: 22, right: 22),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        minimumSize: const Size.fromHeight(50),
                        // fixedSize: Size.fromWidth(
                        //     (MediaQuery.of(context).size.width - 64) / 2),
                        // backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color(0xFF006338),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      // ignore: avoid_print
                      print("OK");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookReading(
                                    book: widget.book,
                                  )));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/book.svg',
                      width: 24,
                      height: 24,
                      color: const Color(0xFF006338),
                    ),
                    label: Text(
                      FlutterI18n.translate(context, 'book.info.read-book'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006338)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    FlutterI18n.translate(context, 'book.info.intro'),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.book.data["intro"]
                            [FlutterI18n.translate(context, 'current_lang')] ??
                        "",
                    style: TextStyle(
                        fontFamily: FlutterI18n.translate(context, 'font'),
                        fontSize: 14,
                        color: Color(0xFF707070)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, 'book.info.same'),
                    style: Theme.of(context).textTheme.headline2,
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
                        return Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: ItemBook(
                            book: _list[index],
                            related: true,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
