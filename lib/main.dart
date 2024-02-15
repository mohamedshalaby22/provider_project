import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/Controller/bottom_nav.dart';
import 'package:provider_project/Controller/products.dart';
import 'package:provider_project/View/Pages/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsController()),
        ChangeNotifierProvider(create: (context) => BNBar()),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.grey[300]),
        debugShowCheckedModeBanner: false,
        home: const HomeLayout(),
      ),
    );
  }
}
