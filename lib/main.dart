import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/core/routers/routers.dart';
import 'app/core/services/remote/dio_http_client_service.dart';
import 'app/core/services/remote/http_client_service.dart';
import 'app/modules/product/repository/product_repository_imp.dart';
import 'app/modules/product/repository/product_repository_interface.dart';
import 'app/modules/product/screens/detail/store/detail_store.dart';
import 'app/modules/product/screens/home/store/home_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        Provider<IHttpService>(
            create: (context) => DioHttpServiceImp(context.read())),
        Provider<IProductRepository>(
            create: (context) =>
                ProductRepositoryImp(httpService: context.read())),
        ChangeNotifierProvider(
            create: (context) => HomeStore(repository: context.read())),
        ChangeNotifierProvider(
            create: (context) => DetailStore(repository: context.read())),
      ],
      child: MaterialApp(
        initialRoute: Routers.initialRoute,
        onGenerateRoute: Routers.generateRoutes,
      ),
    );
  }
}
