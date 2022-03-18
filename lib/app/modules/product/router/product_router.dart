import 'package:flutter/material.dart';

class ProductRouter extends StatelessWidget {
  const ProductRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (context) {
              return  Container();
            },
          );
        }
      },
    );
  }
}
