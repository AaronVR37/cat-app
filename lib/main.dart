import 'package:camera/camera.dart';
import 'package:cat_application/screens/home_page.dart';
import 'package:flutter/material.dart';


Future <void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final first = cameras.first;

  runApp(SqliteApp(firstCamera: first,));
}

class SqliteApp extends StatelessWidget {
  final CameraDescription firstCamera;

  const SqliteApp({Key? key, required this.firstCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Application',
      initialRoute: 'home',
      routes: {
        'home':(context) => HomePageWidget(firstCamera: firstCamera)
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF38004D)
        )
      ),
    );
  }
}