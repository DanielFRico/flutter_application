import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/app/form_product/presentation/pages/form_product_page.dart';
import 'package:namer_app/app/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/presentation/pages/login_page.dart';
import 'signup/presentation/pages/signup_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(routes: [
      GoRoute(
          path: "/login",
          builder: (_, __) => LoginPage(),
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool isAuth = prefs.getBool("login") ?? false;
            if (isAuth) {
              return "/";
            }
            return null;
          }),
      GoRoute(
          path: "/sign-up", builder: (_, __) => SignupPage(), name: "sign-up"),
      GoRoute(
          path: "/",
          builder: (_, __) => HomePage(),
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool isAuth = prefs.getBool("login") ?? false;
            if (!isAuth) {
              return "/login";
            }
            return null;
          }),
      GoRoute(
          path: "/form-product",
          builder: (_, __) => FormProductPage(),
          name: "form-product"),
    ]);
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class TestStateful extends StatefulWidget {
  const TestStateful({super.key});
  @override
  State<TestStateful> createState() => TestStatefulState();
}

class TestStatefulState extends State<TestStateful> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
