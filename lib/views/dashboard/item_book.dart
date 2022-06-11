import 'package:arbook/models/arbook.dart';
import 'package:arbook/views/book/info.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ItemBook extends StatelessWidget {
  // final Book book;
  final ArBook book;

  final bool? related;

  const ItemBook({Key? key, required this.book, this.related}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint(book.uuid);
    return InkWell(
        onTap: () {
            if (related==true) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookInfo(
                        book: book,
                      )));
          } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookInfo(
                        book: book,
                      )));
            }

        },
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFECECEC), width: 1),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: CachedNetworkImage(
                    width: 90,
                    height: 120,
                    fit: BoxFit.cover,
                    imageUrl: 'http://arbook.vietpix.com' +
                        book.data["image"][0]["url"],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 90,
              child: Text(
                book.data["title"]
                        [FlutterI18n.translate(context, "current_lang")] ??
                    book.data["title"]["vi"],
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FlutterI18n.translate(context, "font"),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }
}
