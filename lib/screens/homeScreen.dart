import 'dart:io';

import 'package:flutter/material.dart';

import 'package:instagram_downloader/data/dart/list.dart';
import 'package:instagram_downloader/screens/privacy_policy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PermissionStatus status;
  int denyCnt = 0;
  List<HomeList> homeList = HomeList.homeList;

  void _getPermission() async {
    status = await Permission.storage.request();

    if (status == PermissionStatus.permanentlyDenied) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Storage Permission Required'),
            content: Text('Enable Storage Permission from App Setting'),
            actions: <Widget>[
              FlatButton(
                child: Text('Open Setting'),
                onPressed: () async {
                  openAppSettings();
                  exit(0);
                },
              )
            ],
          );
        },
      );
    } else {
      while (!status.isGranted) {
        if (denyCnt > 20) {
          exit(0);
        }
        status = await Permission.storage.request();
        denyCnt++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Colors.pinkAccent,
           // color: Colors.orangeAccent
          ),
          child:  FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(
                        height: 25.0,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: getData(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox();
                            } else {
                              return GridView(
                                padding: EdgeInsets.only(top: 0, left: 12, right: 12),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: List.generate(
                                  homeList.length,
                                      (index) {
                                    return HomeListView(
                                      listData: homeList[index],
                                      callBack: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => homeList[index].navigateScreen,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,



                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),


    );
  }


}

class HomeListView extends StatelessWidget {
  final HomeList listData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation animation;

  const HomeListView({Key key, this.listData, this.callBack, this.animationController, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 90.0,
              child: RaisedButton(
                onPressed:callBack,

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(


                      borderRadius: BorderRadius.circular(150.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("Downloader",textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,


                      ),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Container(
              height: 90.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
                },

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(


                      borderRadius: BorderRadius.circular(150.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("Privacy Policy",textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,


                      ),),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
