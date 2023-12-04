import '../api/endpoints.dart';
import '../../../navigation/app_routes.dart';
import '../../../navigation/navigation.dart';
import '../../../presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oversight Mobile',
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      theme: ThemeData(
        fontFamily: 'Gilroy',
      ),
      home: const LoginPage(),
      navigatorKey: navigatorKey,
      routes: appRoutes,
      initialRoute: Endpoints.login,
    );
  }
}
