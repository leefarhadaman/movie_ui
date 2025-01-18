// movie_app.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ui/main_screens/mainscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MovieApp());
}
class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black87,
        brightness: Brightness.dark,
      ),
      home: MainScreen(),
    );
  }
}











