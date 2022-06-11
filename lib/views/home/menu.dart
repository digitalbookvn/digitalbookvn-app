import 'package:arbook/models/category.dart';
import 'package:arbook/views/list/list_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    _callAPI();
  }

  void _callAPI() async {
    // final Response response = await API.get({},
    //     // '$urlBase/Tour3d/GetByPageID?lang=vi&pageSize=${this.pageSize}&pageId=${this.pageId}'
    //     '$urlBase/Site?lang=vi'
    // );
    // setState(() {
    //   // list_pano3d = (response.data as List<dynamic>)
    //   //     .map((dictionary) => Pano3D.fromJson(dictionary))
    //   //     .toList();
    //   listPano3d = response.data["Slide3DUrls"];
    //   print(listPano3d);
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Category> list = [
      Category(
          id: 1,
          ten: FlutterI18n.translate(context, 'menu.arbook'),
          anh: 'assets/images/category/ar.png',
          filter: 'arbook'),
      Category(
          id: 2,
          ten: FlutterI18n.translate(context, 'menu.level1'),
          anh: 'assets/images/category/lvl-1.png',
          filter: '1ce0d01b-4bab-4021-82c6-db9e13361719'),
      Category(
          id: 3,
          ten: FlutterI18n.translate(context, 'menu.level2'),
          anh: 'assets/images/category/lvl-2.png',
          filter: '0692a70d-f7f9-428a-9923-d2a165a35553'),
      Category(
          id: 4,
          ten: FlutterI18n.translate(context, 'menu.level3'),
          anh: 'assets/images/category/lvl-3.png',
          filter: '3d5cde98-12c2-41f2-9ede-d1f2a29d9f22'),
      Category(
          id: 5,
          ten: FlutterI18n.translate(context, 'menu.level4'),
          anh: 'assets/images/category/lvl-4.png',
          filter: '08364b94-08af-4eea-8e1b-cd6d5f7e7604'),
      Category(
          id: 6,
          ten: FlutterI18n.translate(context, 'menu.level5'),
          anh: 'assets/images/category/lvl-5.png',
          filter: '7c636389-c908-44a8-86cd-629aad657eef'),
    ];

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: ListView(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              height: 50,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   'Xin chào, Min',
                  //   style: Theme.of(context).textTheme.headline1,
                  // ),
                  const Spacer(),
                  Container(
                    // margin: EdgeInsets.only(right: 23),
                    width: 30,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 15,
                        height: 15,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFECECEC),
                        width: 1.0,
                      ),
                    ),
                  ),
                ],
              )),
          GridView.builder(
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            //
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListBook(title: list[index].ten, filter: {'category':list[index].filter})));
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(list[index].anh)),
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Image.asset(
                    //   list[index].anh,
                    //   width: 150,
                    //   height: 150,
                    // ),
                    Text(
                      list[index].ten,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
