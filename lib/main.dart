import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:madproject/pages/onboard/onboarding_page.dart';
import 'package:madproject/providers/cart_provider.dart';
import 'package:madproject/providers/favs_provider.dart';
import 'package:madproject/providers/orders_provider.dart';
import 'package:madproject/providers/products.dart';
import 'package:madproject/providers/theme_provider.dart';
import 'package:madproject/services/auth.dart';
import 'package:madproject/services/face_posts_data.dart';
import 'package:madproject/theme.dart';

int init;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // init = await prefs.getInt("init");
  // await prefs.setInt("init", 1);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /*-----------------------------------------------------------------------------------------------*/
        /*---------------------------------------  Facebook Provider  --------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        FutureProvider(
            initialData: null,
            create: (context) => FacePostsServices.getFacebookData()),
        /*-----------------------------------------------------------------------------------------------*/
        /*---------------------------------------  Theme Provider  --------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        /*-----------------------------------------------------------------------------------------------*/
        /*------------------------------------  Products Provider  --------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        /*-----------------------------------------------------------------------------------------------*/
        /*---------------------------------------  Cart Provider  --------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        /*-----------------------------------------------------------------------------------------------*/
        /*---------------------------------------  Favs Provider  --------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(
          create: (_) => FavsProvider(),
        ),
        /*-----------------------------------------------------------------------------------------------*/
        /*--------------------------------------  Orders Provider  --------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      builder: (context, child) {
        /*---------------------------------------  Theme Provider  --------------------------------------*/
        return Consumer<ThemeProvider>(
          builder: (context, value, child) {
            /*---------------------------------------  Auth Provider  --------------------------------------*/
            return Provider<AuthBase>(
              create: (context) => Auth(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                /*------------------------------------  App Theme  ---------------------------------------*/
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: (value.theme) ? ThemeMode.dark : ThemeMode.light,
                home: IntroPage(),
                // initialRoute: init == 0 || init == null ? "onboard" : "Home",
                // routes: {
                //   'onboard': (context) => Onboard(),
                //   'Home': (context) => LandingPage(), //LandingPage(),
                // },
              ),
            );
          },
        );
      },
    );
  }
}
