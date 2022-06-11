import 'package:arbook/services/api.dart';
import 'package:arbook/views/book/info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:arbook/models/arbook.dart';

class ItemBanner extends StatelessWidget {
  final ArBook book;

  const ItemBanner({Key? key, required this.book}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BookInfo(book: book,)));
      },
      child: Container(

        margin: const EdgeInsets.only(left: 8,right:8),
        width: 330.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFECECEC), width: 0.3),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //       color: Colors.grey, blurRadius: 2.0, offset: Offset(0.0, 0.5))
          // ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
          CachedNetworkImage(
              imageUrl: urlBase+ book.data['banner'][0]['url'],
              placeholder: (context, url) => Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xBC363636),
                        color: Color(0xFFFAFAFA),
                      ))),
              width: 320,
              height: 200,
              fit : BoxFit.cover
          ),
        ),
      ),
    );
  }

}
