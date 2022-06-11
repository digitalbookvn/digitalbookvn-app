
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Webview extends StatelessWidget {

  final String url;

  const Webview({Key? key, required this.url}) : super(key: key);


  _launchURL(link) async {
    // var link = url;

    if (await canLaunch(link)) {
      print("$link");
      await launch(link,
          forceWebView: false, enableJavaScript: true, forceSafariVC:
          false);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top:30),
              padding: const EdgeInsets.only(right: 22),
              height: 50,
              // color: Theme.of(context).colorScheme.secondary,
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
            child: WebView(
              initialUrl: 'https://3dbooth.egal.vn/hungpv/ar/meo.html',
              // initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.contains(RegExp('^intent://.*\$')))  {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                }
                print(request.url);
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }

}