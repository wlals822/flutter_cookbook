import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/contents/advanced/riveDemo.dart';
import 'package:flutter_cookbook/contents/animations.dart';
import 'package:flutter_cookbook/contents/bottomNavbar.dart';
import 'package:flutter_cookbook/contents/bottomSheet.dart';
import 'package:flutter_cookbook/contents/buttons.dart';
import 'package:flutter_cookbook/contents/contentlist.dart';
import 'package:flutter_cookbook/contents/cupertino/CupertinoButtonDemo.dart';
import 'package:flutter_cookbook/contents/cupertino/cupertinoContextMenuPage.dart';
import 'package:flutter_cookbook/contents/dialogShowcase.dart';
import 'package:flutter_cookbook/contents/image.dart';
import 'package:flutter_cookbook/contents/navigationRail.dart';
import 'package:flutter_cookbook/contents/placeholder.dart';
import 'package:flutter_cookbook/contents/provider.dart';
import 'package:flutter_cookbook/contents/snackbar.dart';
import 'package:flutter_cookbook/contents/stepper.dart';
import 'package:flutter_cookbook/contents/texts.dart';
import 'package:flutter_cookbook/webLauncher.dart';

import 'contents/cupertino/CupertinoDatePickerItem.dart';
import 'contents/navigationRail.dart';
import 'contents/slider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MyApp());
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-6763874036478749/4545164378';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-6763874036478749/3091244805';
  }
  return null;
}

String getBannerAdId() {
  if (Platform.isAndroid) {
    return 'ca-app-pub-6763874036478749/8689451189';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-6763874036478749/6554242437';
  }
  return null;
}

var aboutBannerIDAndroid = 'ca-app-pub-6763874036478749/8689451189';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tabIndex = 0;

  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    interstitialAd = AdmobInterstitial(adUnitId: getInterstitialAdUnitId());
    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    Widget menuList;

    switch (tabIndex) {
      case 0:
        menuList = MaterialList();
        break;
      case 1:
        menuList = CupertinoList();
        break;
      case 2:
        menuList = AdvancedList();
        break;
    }
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 15, 76, 129),
        child: menuList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (position) {
          setState(() {
            if (position == 3) {
              showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    "assets/launcher/fullicon.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ),
                  applicationName: "Flutter Cookbook",
                  applicationLegalese: "Project for flutter learners. ",
                  children: [
                    OutlineButton(
                      child: Text("View on Github"),
                      onPressed: () {
                        showBrowser(
                            "https://www.github.com/wlals822/flutter_cookbook");
                      },
                    )
                  ]);
            } else {
              tabIndex = position;
            }
          });
        },
        currentIndex: tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: "Material",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "Cupertino",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: "Advanced",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications),
            label: "Abort",
          ),
        ],
      ),
    );
  }
}

class MaterialList extends StatelessWidget {
  final List<CookItem> cooks = [
    TextDemo(),
    ButtonsDemo(),
    SliderDemo(),
    AnimationsDemo(),
    ImageDemo(),
    SnacbarDemo(),
    AlertDialogDemo(),
    NavigationRailDemo(),
    BottomSheetDemo(),
    BottomNavbarDemo(),
    StepperDemo(),
    PlaceHolderDemo(),
    ProviderDemo()
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cooks.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTitle(),
            );
          } else if (index == cooks.length + 1) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListFooter(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CookContent(item: cooks[index - 1]),
            );
          }
        });
  }
}

class CupertinoList extends StatelessWidget {
  final List<CookItem> cooks = [
    CupertinoActionSheetItem(),
    CupertinoContextMenuDemo(),
    CupertinoDatePickerItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cooks.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTitle(),
            );
          } else if (index == cooks.length + 1) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListFooter(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CookContent(item: cooks[index - 1]),
            );
          }
        });
  }
}

class AdvancedList extends StatelessWidget {
  final List<CookItem> cooks = [
    RiveItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cooks.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTitle(),
            );
          } else if (index == cooks.length + 1) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListFooter(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CookContent(item: cooks[index - 1]),
            );
          }
        });
  }
}

class ListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 20),
      child: Text(
        "Flutter cookbook🍳",
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.display2.fontSize,
            color: Colors.white),
      ),
    );
  }
}

class ListFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            Text(
              "🔨Working Now!✏️",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline4.fontSize,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await showBrowser(
                    "https://www.github.com/wlals822/flutter_cookbook");
              },
              child: Text(
                "or request new feature",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: FutureBuilder<bool>(
                  initialData: false,
                  future: Admob.requestTrackingAuthorization(),
                  builder: (context, snapshot) {
                    if (snapshot.data) {
                      return AdmobBanner(
                        adUnitId: getBannerAdId(),
                        adSize: AdmobBannerSize.FULL_BANNER,
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CookContent extends StatelessWidget {
  final CookItem item;

  CookContent({this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        item.onSelect(context);
      },
      child: Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Text(
            item.title,
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
    );
  }
}
