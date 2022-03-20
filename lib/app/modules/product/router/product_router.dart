import 'package:flutter/material.dart';
import '../screens/detail/route/detail_arguments.dart';
import '../screens/detail/route/detail_route.dart';
import '../screens/home/route/home_route.dart';

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
              return const HomeRoute();
            },
          );
        }
        if (settings.name == '/detail') {
          return MaterialPageRoute(
            builder: (context) {
              return DetailRoute(
                arguments: settings.arguments as DetailArguments,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
