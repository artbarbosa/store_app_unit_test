import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app_unit_test/app/core/services/remote/dio_http_client_service.dart';
import 'package:store_app_unit_test/app/modules/product/repository/product_repository_imp.dart';
import 'package:store_app_unit_test/app/modules/product/repository/product_repository_interface.dart';
import 'package:store_app_unit_test/app/modules/product/screens/home/container/home_container.dart';
import 'package:store_app_unit_test/app/modules/product/screens/home/store/home_store.dart';

import 'app/core/services/remote/http_client_service.dart';

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
        Provider<IHttpService>(create: (context) => DioHttpServiceImp(context.read())),
        Provider<IProductRepository>(
            create: (context) => ProductRepositoryImp(httpService: context.read())),
        ChangeNotifierProvider(
            create: (context) => HomeStore(repository: context.read())),
      ],
      child: const MaterialApp(
        home: HomeContainer(),
      ),
    );
  }
}
