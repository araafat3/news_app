import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamzahllc/core/helper/local_storage.dart';
import 'package:hamzahllc/core/helper/navigation/app_navigator.dart';
import 'package:hamzahllc/core/helper/navigation/router.dart';
import 'package:hamzahllc/features/screens/news_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().initiateStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      navigatorKey: AppNavigator().navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsScreen(),
    );
  }
}
