import 'package:flutter/material.dart';
import 'package:store_app_unit_test/app/modules/product/screens/home/container/home_container.dart';

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
              return  const HomeContainer();
            },
          );
        }
        return null;
      },
    );
  }
}
