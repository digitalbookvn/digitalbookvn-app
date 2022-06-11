import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:arbook/models/arbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class SimpleScreen extends StatefulWidget {
  const SimpleScreen({Key? key, required this.gameId, required this.book})
      : super(key: key);
  final ArBook book;
  final String gameId;

  @override
  _SimpleScreenState createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  late UnityWidgetController _unityWidgetController;
  List<dynamic> listModel = [];
  List<dynamic> offlineListModel = [];
  List<String> downloadFiles = [];
  String path = "";
  bool gameReady = false;

  bool assetsLoaded = false;

  bool gameStart = false;

  @override
  void initState() {
    super.initState();
    getLocalPath();
    for (var item in widget.book.data["game"]["models"]) {
      listModel.add({
        "name": item["title"]["vi"] ?? "",
        "model": "http://arbook.vietpix.com" + item["model"][0]["url"],
        "items": item["model"][0]["items"] ?? [],
        "thumb":
            "http://arbook.vietpix.com/content/uploads/arbook/2022/05/04/1-667471694.png",
        "audio":
            "http://arbook.vietpix.com/content/uploads/arbook/2022/05/08/blank-93073436.mp3"
      });
    }
    downloadBookAsset();
    setState(() {
      assetsLoaded = true;
    });

    Future.delayed(
      // ignore: prefer_const_constructors
      Duration(milliseconds: 1000),
      () async {
        setState(() {
          gameReady = true;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getLocalPath() async {
    Directory dir = await getApplicationSupportDirectory();

    setState(() {
      path = dir.path;
      debugPrint(path);
    });
  }

  Future<void> downloadBookAsset() async {
    listModel.asMap().forEach((index, model) async {
      if (!downloadFiles.contains(model["thumb"])) {
        bool fileExist = await checkFileExist(model["thumb"]);

        if (!fileExist) {
          downloadFiles.add(model["thumb"]);
        }
      }
      if (!downloadFiles.contains(model["audio"])) {
        bool fileExist = await checkFileExist(model["audio"]);

        if (!fileExist) {
          downloadFiles.add(model["audio"]);
        }
      }
      if (!downloadFiles.contains(model["model"])) {
        String ext = model["model"].toString().split('.').last;
        if (ext != "zip") {
          bool fileExist = await checkFileExist(model["model"]);

          if (!fileExist) {
            downloadFiles.add(model["model"]);
          }
          offlineListModel.add({
            "name": model["name"],
            "model": path + "/" + model["model"].toString().split("/").last,
            "thumb": path + "/" + model["thumb"].toString().split("/").last,
            "audio": path + "/" + model["audio"].toString().split("/").last
          });
        } else {
          debugPrint("skip zip file");
          for (var modelItem in model["items"]) {
            if (!downloadFiles.contains(modelItem)) {
              bool fileExist = await checkFileExist(modelItem);

              if (!fileExist) {
                downloadFiles.add("http://arbook.vietpix.com" + modelItem);
              }
            }
            String ext = modelItem.toString().split('.').last;
            if (ext.toLowerCase() == "fbx") {
              offlineListModel.add({
                "name": model["name"],
                "model": path +
                    "/" +
                    modelItem.toString().toString().split("/").last,
                "thumb": path + "/" + model["thumb"].split("/").last,
                "audio": path + "/" + model["audio"].toString().split("/").last
              });
            }
          }
        }
      }

      debugPrint(downloadFiles.toString());
      downloadFiles.asMap().forEach((key, value) async {
        await downloadFile(value);
      });
    });
  }

  Future<void> downloadFile(url) async {
    Dio dio = Dio();
    String filename = getFileNameFromUrl(url);
    try {
      await dio.download(url, "$path/$filename",
          onReceiveProgress: (rec, total) {
        // debugPrint("Rec: $rec , Total: $total");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint("Download completed $filename");
  }

  String getFileNameFromUrl(url) {
    return url.toString().split("/").last;
  }

  Future<bool> checkFileExist(url) async {
    String filename = getFileNameFromUrl(url);
    bool fileExist = await File(path + "/" + filename).exists();
    if (fileExist) {
      debugPrint(filename + " EXIST");
    }
    return fileExist;
  }

  void startGame(String gameId) async {
    bool? unityReady = await _unityWidgetController.isLoaded();
    if (unityReady != null) {
      if (unityReady) {
        _unityWidgetController.pause();

        _unityWidgetController.postMessage(
          'GameManager',
          'SelectLevel',
          gameId,
        );

        final _isPaused = await _unityWidgetController.isPaused();
        if (_isPaused != null) {
          if (_isPaused) {
            debugPrint("is_pause");
            Future.delayed(
              // ignore: prefer_const_constructors
              Duration(milliseconds: 500),
              () async {
                await _unityWidgetController.resume();
              },
            );

            Future.delayed(
              // ignore: prefer_const_constructors
              Duration(milliseconds: 2000),
              () {
                setState(() {
                  gameStart = true;
                });
              },
            );
          } else {
            debugPrint("no, other problem");
          }
        }
      } else {
        debugPrint("not ready");
      }
    } else {
      debugPrint("Null");
    }
  }

  void stopGame(String gameId) {
    _unityWidgetController.postMessage('GameManager', 'CloseGame', gameId);
  }

  void onUnityMessage(message) {
    debugPrint('Received message from unity: ${message.toString()}');
    if (message == "View3D" && widget.gameId == "0") {
      // debugPrint(jsonEncode(listModel[0]).toString());
      // jsonEncode(listModel)
      startView3D('{"datas":' + jsonEncode(offlineListModel).toString() + '}');
    }
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    debugPrint('Received scene loaded from unity: ${scene!.name}');
    debugPrint(
        'Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(UnityWidgetController controller) async {
    _unityWidgetController = controller;
  }

  void startView3D(String data) {
    _unityWidgetController.postMessage('GameManager', 'DataReceive', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Card(
            // margin: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20.0),
            // ),
            child: gameReady
                ? UnityWidget(
                    onUnityCreated: onUnityCreated,
                    onUnityMessage: onUnityMessage,
                    onUnitySceneLoaded: onUnitySceneLoaded,
                    // unloadOnDispose: true,
                  )
                : const SizedBox(),
          ),
          gameStart
              ? const SizedBox()
              : Container(
                  color: const Color(0xFFDFF1EB),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.35,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                      gameStart && (!assetsLoaded)
                          ? const SizedBox()
                          : TextButton(
                              child: const Text(
                                'Start',
                              ),
                              onPressed: () {
                                startGame(widget.gameId);
                                debugPrint('click start game ${widget.gameId}');
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 12),
                                  backgroundColor: const Color(0xFF006338),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xFF006338),
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/splash.png',
                        width: MediaQuery.of(context).size.width,
                        height: 0.96 * MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              color: Colors.white,
              icon: SvgPicture.asset(
                'assets/icons/back.svg',
                width: 20,
                height: 20,
                // color: Colors.white,
              ),
              onPressed: () async {
                await _unityWidgetController.pause();
                final _isPaused = await _unityWidgetController.isPaused();
                if (_isPaused != null) {
                  if (_isPaused) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
