import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Controller/App.dart';
import 'package:sampleproject/Firebase/auth.dart';
import 'package:sampleproject/Screen/test.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/Screen/homePageSceen.dart';
import 'package:sampleproject/admin/addnewQuizScreen.dart';
import 'package:sampleproject/admin/adminReferans.dart';
import 'package:sampleproject/admin/adminhomePageSceen.dart';
import 'package:sampleproject/auth/AdimnAuthMiddleware.dart';
import 'package:sampleproject/auth/AuthMiddleware.dart';
import 'package:sampleproject/auth/startScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
late SharedPreferences adminPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pref = await SharedPreferences.getInstance();
  adminPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  App s1 = Get.put(App());
  @override
  void initState() {
    s1.getDoc();

    // s1.FetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
        // home: startScreen(),
        getPages: [
          GetPage(
            name: '/',
            page: () => adminReferans(),
            middlewares: [AdminAuthMiddleware()],
          ),
          GetPage(
              name: '/adminhomePageSceen', page: () => adminhomePageSceen()),
        ],
        /*    getPages: [
          GetPage(
            name: '/',
            page: () => startScreen(),
            middlewares: [AuthMiddleware()],
          ),
          GetPage(
            name: '/homePageScreen',
            page: () => homePageScreen(),
          ),
        ], */
      ),
    );
  }
}
