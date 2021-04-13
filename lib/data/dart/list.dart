import 'package:flutter/widgets.dart';
import 'package:instagram_downloader/screens/downloaderScreen.dart';



class HomeList {
  String title;
  Widget navigateScreen;
  String imagePath;

  HomeList({
    this.title,
    this.navigateScreen,
    this.imagePath = '',
  });

  static List<HomeList> homeList = [

    HomeList(
      title: 'Instagram',
      imagePath: 'assets/images/instagramLogo.png',
      navigateScreen: InstagramDownload(),
    ),

  ];
}

