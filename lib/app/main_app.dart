import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeappv2/app/form_product/presentacion/pages/form_product_page.dart';
import 'package:storeappv2/app/home/presentacion/pages/home_page.dart';
import 'package:storeappv2/app/login/presentacion/pages/login_page.dart';
import 'package:storeappv2/app/sing_up/presentacion/pages/form_sing_up_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          builder: (_, _) => LoginPage(),
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            if (authenticated) {
              return "home";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/home",
          builder: (_, _) => HomePage(),
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            if (!authenticated) {
              return "/";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SingUpPage(),
          name: "sign-up",
        ),
        GoRoute(
          path: "/form-product",
          builder: (_, _) => FormProductPage(),
          name: "form-product",
        ),
        GoRoute(
          path: "/form-product/:id",
          builder:
              (_, state) => FormProductPage(id: state.pathParameters["id"]),
          name: "form-product-u",
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router, debugShowCheckedModeBanner: false,);
    //return const MaterialApp(
    //  home: LoginPage(),
    //);
  }
}
