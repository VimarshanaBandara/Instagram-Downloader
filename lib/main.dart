
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:instagram_downloader/data/dart/appTheme.dart';



import 'screens/homeScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
  );
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Downloader',
      theme: ThemeData(
        textTheme: AppTheme.textTheme,
        accentColor: Colors.blue,
        textSelectionColor: Colors.blue,
        textSelectionHandleColor: Colors.blue,
        platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

