import 'package:arbook/models/arbook.dart';
import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/dashboard/list_banner.dart';
import 'package:arbook/views/dashboard/list_recent.dart';
import 'package:arbook/views/dashboard/list_recommend.dart';
import 'package:arbook/views/dashboard/list_trend.dart';
import 'package:arbook/views/dashboard/list_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({Key? key}) : super(key: key);


  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final List<ArBook> _list = [];

  @override
  void initState() {
    _callAPI();
    super.initState();
  }

  void _callAPI() async {
    final Response response = await API.get({},
        'http://arbook.vietpix.com/arbook/api/books/list?pageNumber=1&pageSize=20'
    );
    setState(() {
      var list = (response.items)
          .map((dictionary) => ArBook.fromJson(dictionary))
          .toList();
      _list.addAll(list);
    });
  }


  @override
  Widget build(BuildContext context) {
    //
    return ListView(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            height: 50,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FlutterI18n.translate(context, "dashboard.title"),
                  style: Theme.of(context).textTheme.headline1,
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    debugPrint("OK");
                    // print(_list);
                  },
                  child: Container(
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
                ),
              ],
            )),
        const ListBanner(),
        const ListRecent(),
        const ListNew(),
        const ListRecommend(),
        const ListTrend(),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
