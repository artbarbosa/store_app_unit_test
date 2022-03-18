import 'package:flutter/material.dart';
import '../../modules/product/router/product_router.dart';

class Routers {
  static String get initialRoute => '/product';

  static Map<String, Widget Function(BuildContext, dynamic)> routes = {
    '/product': (_, __) => const ProductRouter(),
  };

  static Route? generateRoutes(RouteSettings settings) {
    final routerName = settings.name;
    final routerArgs = settings.arguments;

    final navigateTo = routes[routerName];
    if (navigateTo == null) return null;

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(context, routerArgs),
    );
  }
}
