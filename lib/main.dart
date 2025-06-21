import 'package:data_apk/screens/student_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {

    final base = ThemeData.dark();

    return MaterialApp(
      title: 'Sabilillah Mini Dashboard',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.green[900],
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.greenAccent[200],
          linearTrackColor: Colors.green[900]
        ),
        appBarTheme: AppBarTheme(
          color: Colors.green[900],
          elevation: 3,
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
          titleTextStyle: base.textTheme.headlineMedium
          ?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        ),
        cardColor: Colors.grey[850],
        colorScheme: base.colorScheme.copyWith(
          primary: Colors.white,
          secondary: Colors.green[900],
          onSecondary: Colors.greenAccent,
          surface: Colors.grey[850],
          // background: Colors.black
        ),
        textTheme: base.textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.green[50]
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[350],
        )
      ),
      home: StudentListScreen()
    );
  }
}