import 'dart:ui';

import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/language.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/services/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:audioplayers/audioplayers.dart';

class BookReading extends StatefulWidget {
  final ArBook book;

  const BookReading({Key? key, required this.book}) : super(key: key);

  // final String id;
  // final String lang;
  // const BookReading({Key? key, required this.id, required this.lang}) : super(key: key);

  @override
  BookReadingState createState() => BookReadingState();
}

class BookReadingState extends State<BookReading> {
  CarouselController carouselController = CarouselController();
  AudioPlayer audioPlayer = AudioPlayer();

  bool startedPlaying = false;

  List<Lang> lang = languages;

  List pages = [];

  String currentLang = '';
  var currentPage = 0;
  bool mute = false;
  bool autoplay = true;
  bool playing = true;

  String user = '';

  @override
  void initState() {
    debugPrint(widget.book.uuid);
    addReadBook();
    setState(() {
      pages = widget.book.data["pages"];
    });

    super.initState();
    initAudioPlayer();
    autoplayPage();
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

  Future<void> addReadBook() async {
    await _readAll();

    debugPrint(secret['uuid']);
    final Response response = await API.post({'user':secret['uuid'],'book':widget.book.uuid}, '$urlBase/arbook/api/user/view-book');
    debugPrint(response.error.toString());
  }

  @override
  void didChangeDependencies() {
    setState(() {
      currentLang = FlutterI18n.translate(context, 'current_lang');
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  autoplayPage() async {
    await playPage();
  }

  nextPage() {
    if (playing) {
      if (currentPage == (pages.length - 1)) {
        setState(() {
          playing = false;
        });

        carouselController.animateToPage(0);
      } else {
        carouselController.nextPage();
      }
    }
  }

  playPage() async {
    // AudioCache cache = AudioCache(fixedPlayer: audioPlayer);
    // cache.play(pages[currentPage]["audio"][currentLang]);
    String playUrl;
    if (pages[currentPage]["audio"][currentLang] != null) {
      playUrl = 'http://arbook.vietpix.com' +
          pages[currentPage]["audio"][currentLang]["url"];
    } else {
      playUrl = "http://arbook.vietpix.com/content/uploads/arbook/2022/05/08/blank-93073436.mp3";
    }

    audioPlayer.play(playUrl);
  }

  initAudioPlayer() {
    audioPlayer.onPlayerCompletion.listen((event) {
      if (autoplay) {
        if (playing) {
          nextPage();
        }
      } else {
        if (playing) {
          setState(() {
            playing = !playing;
          });
        }
      }
    });
  }

  changePlaying() {
    setState(() {
      playing = !playing;
    });
    if (playing) {
      playPage();
    } else {
      audioPlayer.stop();
    }
  }

  Widget subtitle1() {
    // font by currentLang
    var sub = pages[currentPage]["sub_title"][currentLang] ??
        pages[currentPage]["sub_title"]["vi"] ??
        "";
    // sub = sub ?? "";
    // sub = sub.replaceAll("\n", ' ');
    sub = sub.trim();

    return Text(sub,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF006338),
            fontWeight: FontWeight.bold,
            fontFamily: FlutterI18n.translate(context, 'font')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        // color: Theme.of(context).colorScheme.secondary,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
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
                    const Spacer(),
                    PopupMenuButton(
                        icon: SvgPicture.asset(
                          'assets/icons/lang.svg',
                          width: 24,
                          height: 24,
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        enabled: true,
                        onSelected: (Lang lang) {
                          setState(() {
                            currentLang = lang.slug;
                          });
                        },
                        itemBuilder: (context) {
                          return lang.map((Lang lang) {
                            return PopupMenuItem(
                              value: lang,
                              child: Text(
                                lang.name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            );
                          }).toList();
                        }),
                    FlutterSwitch(
                      padding: 4,
                      activeText:
                          FlutterI18n.translate(context, 'book.read.autoplay'),
                      inactiveText:
                          FlutterI18n.translate(context, 'book.read.autoplay'),
                      activeTextColor: Colors.white,
                      inactiveTextColor: Colors.white,
                      activeIcon: const Icon(
                        Icons.check,
                        color: Color(0xFF21A56C),
                        // size:20
                      ),
                      toggleSize: 18,
                      inactiveIcon:
                          const Icon(Icons.check, color: Color(0xFF869A95)),
                      valueFontSize: 12.0,
                      value: autoplay,
                      height: 26,
                      width: 90,
                      activeColor: Color(0xFF21A56C),
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          autoplay = val;
                        });
                      },
                    ),
                  ],
                )),
            AbsorbPointer(
              absorbing: autoplay,
              child: CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: pages.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  color: Theme.of(context).colorScheme.primary,
                  // margin: const EdgeInsets.all(12),
                  // padding: const EdgeInsets.all(18),
                  height: 375,
                  child: CachedNetworkImage(
                    imageUrl: 'http://arbook.vietpix.com' +
                        pages[itemIndex]["image"][0]["url"],
                    fit: BoxFit.cover,
                  ),
                ),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height: 375,
                  initialPage: 0,
                  onPageChanged: (int index,
                      CarouselPageChangedReason
                          carouselPageChangedReason) async {
                    setState(() {
                      // if (carouselPageChangedReason.toString() != 'controller') {
                      //   autoplay = false;
                      // }
                      // print(index);
                      currentPage = index;
                      playing = true;

                      // playPage();
                    });
                    if (autoplay && playing) {
                      await autoplayPage();
                    } else {
                      await playPage();
                    }
                  },
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SingleChildScrollView(controller:ScrollController(keepScrollOffset: false),scrollDirection: Axis.vertical,child: subtitle1()),
            )),
            const SizedBox(height: 10,),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: SvgPicture.asset(
                      'assets/icons/3d.svg',
                      width: 15,
                      height: 15,
                    ),
                    style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: const CircleBorder(),
                        side: const BorderSide(
                          color: Color(0xFF006338), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        backgroundColor: const Color(0xFF21A56C),
                        fixedSize: const Size(40, 40) // <-- Splash color
                        ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: SvgPicture.asset(
                      'assets/icons/refresh.svg',
                      width: 15,
                      height: 15,
                    ),
                    style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: const CircleBorder(),
                        side: const BorderSide(
                          color: Color(0xFFD55600), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        // padding: EdgeInsets.all(7),
                        backgroundColor: const Color(0xFFF97923),
                        // <-- Button color
                        fixedSize: const Size(40, 40) // <-- Splash color
                        ),
                  ),
                  OutlinedButton(
                    onPressed: changePlaying,
                    child: playing
                        ? SvgPicture.asset(
                            'assets/icons/pause.svg',
                            width: 15,
                            height: 15,
                          )
                        : SvgPicture.asset(
                            'assets/icons/play.svg',
                            width: 15,
                            height: 15,
                          ),
                    style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: const CircleBorder(),
                        side: const BorderSide(
                          color: Color(0xFFD55600), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1, //width of the border
                        ),
                        // padding: EdgeInsets.all(7),
                        backgroundColor: const Color(0xFFF97923),
                        // <-- Button color
                        fixedSize: const Size(40, 40) // <-- Splash color
                        ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  (currentPage + 1).toString() +
                      " / " +
                      pages.length.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 9,
                ),
                LinearPercentIndicator(
                  // width: 140.0,
                  lineHeight: 5.0,
                  percent: (currentPage + 1) / pages.length,
                  backgroundColor: Colors.white,
                  progressColor: const Color(0xFFF97923),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
