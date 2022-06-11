import 'package:flutter_svg/svg.dart';
// import 'package:model_viewer/model_viewer.dart';


import 'package:arbook/models/book.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelView extends StatefulWidget {
  final String id;

  const ModelView({Key? key, required this.id}) : super(key: key);


  @override
  ModelViewState createState() => ModelViewState();
}

class ModelViewState extends State<ModelView> {
  bool autoplay = true;
  Book book = Book(
    id: 6,
    ten: 'Tractor Brother',
    anh: 'assets/images/book/6.png',
    thoi_luong: '20 mins',
    tom_tat:
    'Hi - Social Service App UI KIT is designed with modern design trends. Small or large scale, suitable for all businesses or startup that provide social. Hi - Social Service App UI KIT is designed with modern design trends. Small or large scale, suitable for all businesses or startup that provide social.',
  );

  List<Book> relatedBooks = [
    Book(
        id: 1,
        ten: '1',
        anh: 'assets/images/book/1.png',
        thoi_luong: '20 phút'),
    Book(
        id: 2,
        ten: '2',
        anh: 'assets/images/book/2.png',
        thoi_luong: '15 phút'),
    Book(
        id: 3,
        ten: '3',
        anh: 'assets/images/book/3.png',
        thoi_luong: '20 phút'),
    Book(
        id: 4, ten: '4', anh: 'assets/images/book/4.png', thoi_luong: '15 phút')
  ];

  @override
  void initState() {
    super.initState();
    // _callAPI();
  }

  // void _callAPI() async {
  //   // final Response response = await API.get({},
  //   //     // '$urlBase/Tour3d/GetByPageID?lang=vi&pageSize=${this.pageSize}&pageId=${this.pageId}'
  //   //     '$urlBase/Site?lang=vi'
  //   // );
  //   // setState(() {
  //   //   // list_pano3d = (response.data as List<dynamic>)
  //   //   //     .map((dictionary) => Pano3D.fromJson(dictionary))
  //   //   //     .toList();
  //   //   listPano3d = response.data["Slide3DUrls"];
  //   //   print(listPano3d);
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top:30),
              padding: const EdgeInsets.only(right: 22),
              height: 50,
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

                ],
              )),
          Expanded(
            child: ModelViewer(
              // src: 'https://modelviewer.dev/shared-assets/models/NeilArmstrong.glb',
              src: 'https://3dbooth.egal.vn/hungpv/ngua.glb',
              // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
              // src:'assets/model/animal/ngua.glb',
              alt: "A 3D model of an astronaut",
              ar: true,
              autoRotate: true,
              cameraControls: true,
            ),
          ),
        ],
      ),


    );
  }
}
