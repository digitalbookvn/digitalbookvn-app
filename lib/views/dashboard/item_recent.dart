import 'package:arbook/models/arbook.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arbook/models/book.dart';
import 'package:arbook/views/book/info.dart';

class ItemRecent extends StatelessWidget {
  final ArBook book;

  const ItemRecent({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookInfo(
                        book: book,
                      )));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: Colors.white,
          //     // border: Border.all(color: Color(0xFF707070), width: 0.3),
          //     boxShadow: <BoxShadow>[
          //       BoxShadow(
          //           color: Colors.grey,
          //           blurRadius: 2.0,
          //           offset: Offset(0.0, 0.5))
          //     ]),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child:
                      // CachedNetworkImage(
                      //   imageUrl: book.anh,
                      //   placeholder: (context, url) => Center(
                      //       child: Container(
                      //           width: 40,
                      //           height: 40,
                      //           child: CircularProgressIndicator(
                      //             backgroundColor: Color(0xBC363636),
                      //             color: Color(0xFFFAFAFA),
                      //           ))),
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      // ),
                      CachedNetworkImage(
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    imageUrl: 'http://arbook.vietpix.com' +
                        (book.data["image"][0]["url"]),
                  )),
              Container(
                height: 70,
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 135,
                      height: 30,
                      child: Text(
                        book.data["title"][
                                FlutterI18n.translate(context, "current_lang")] ??
                            book.data["title"]["vi"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FlutterI18n.translate(context, "font"),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006338)),
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/time.svg',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        // Text(
                        //   book.thoi_luong,
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: Theme.of(context).textTheme.headline4,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
