import 'package:arbook/models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListModel extends StatefulWidget {
  const ListModel({Key? key}) : super(key: key);

  @override
  ListModelState createState() => ListModelState();
}

class ListModelState extends State<ListModel> {
  List<Model> list = [
    Model(
        id: 1,
        ten: '7 colors of a rainbow',
        anh: 'assets/images/animal/tortoise.png',
        object: 'https://3dbooth.egal.vn/hungpv/ar/model/Tortoise.gltf'),
    Model(
        id: 2,
        ten: 'Whose voice is this',
        anh: 'assets/images/animal/cat.png',
        object: 'https://3dbooth.egal.vn/hungpv/ar/model/Cat.gltf'),
    Model(
        id: 3,
        ten: 'Cube Cat Cone Cat',
        anh: 'assets/images/animal/cheetah.png',
        object: 'https://3dbooth.egal.vn/hungpv/ar/model/Cheetah.gltf'),
    Model(
        id: 4,
        ten: 'Little Painter',
        anh: 'assets/images/animal/elephant.png',
        object: 'https://3dbooth.egal.vn/hungpv/ar/model/Elephant.gltf'),
    Model(
        id: 5,
        ten: 'Who is faster',
        anh: 'assets/images/animal/fox.png',
        object: 'https://3dbooth.egal.vn/hungpv/ar/model/Fox.gltf'),
    // Model(
    //     id: 6,
    //     ten: 'Ngựa',
    //     anh: 'assets/images/animal/horse.png',
    //     object: 'https://3dbooth.egal.vn/hungpv/ar/model/Horse.gltf'),
    // Model(
    //     id: 7,
    //     ten: 'Thằn lằn',
    //     anh: 'assets/images/animal/lizard.png',
    //     object: 'https://3dbooth.egal.vn/hungpv/ar/model/HornedLizard.gltf'),
    // Model(
    //     id: 8,
    //     ten: 'Chuột',
    //     anh: 'assets/images/animal/mouse.png',
    //     object: 'https://3dbooth.egal.vn/hungpv/ar/model/Mouse.gltf'),
    // Model(
    //     id: 9,
    //     ten: 'Thỏ',
    //     anh: 'assets/images/animal/rabbit.png',
    //     object: 'https://3dbooth.egal.vn/hungpv/ar/model/Rabbit.gltf'),
    // Model(
    //     id: 10,
    //     ten: 'Rắn',
    //     anh: 'assets/images/animal/snake.png',
    //     object: 'https://3dbooth.egal.vn/hungpv/ar/model/Snake.gltf'),
  ];

  @override
  void initState() {
    super.initState();
    // _callAPI();
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
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: ListView(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(right: 22),
                height: 50,
                // color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/back.svg',
                        width: 18,
                        height: 18,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Text(
                    //   widget.title,
                    //   style: Theme.of(context).textTheme.headline6,
                    // ),
                    const Spacer(),
                    // IconButton(
                    //   icon: SvgPicture.asset(
                    //     'assets/icons/filter.svg',
                    //     width: 24,
                    //     height: 24,
                    //   ),
                    //   onPressed: () {},
                    // ),
                  ],
                )),
            ListView.builder(
              itemCount: list.length,
                           //
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              // crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SimpleScreen(gameId:list[index].id.toString())));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(list[index].ten)
                ),
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
