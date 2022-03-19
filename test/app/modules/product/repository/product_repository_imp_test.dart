import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app_unit_test/app/core/services/remote/dio_http_client_service.dart';
import 'package:store_app_unit_test/app/modules/product/errors/product_errrors.dart';
import 'package:store_app_unit_test/app/modules/product/model/product_model.dart';
import 'package:store_app_unit_test/app/modules/product/repository/product_repository_imp.dart';
import '../../../../mocks/response_products_data_mock.dart';

class DioHttpServiceMock extends Mock implements DioHttpServiceImp {}

void main() {
  late DioHttpServiceImp diohttpService;
  late ProductRepositoryImp repositoryImp;

  setUpAll(() {
    diohttpService = DioHttpServiceMock();
    repositoryImp = ProductRepositoryImp(httpService: diohttpService);
  });
  group('ProductRepositoryImp - Get All Productss', () {
    test('Should return a list of products', () async {
      when(() => diohttpService.get(any())).thenAnswer((_) async => Response(
          data: responseJsonProducts,
          requestOptions: RequestOptions(path: '')));

      var result = await repositoryImp.getAllProducts();

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 20);
    });

    test(
        'Should Throw Dio Erro type connectTimeout Product No Internet Connection ',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          error: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllProducts(),
          throwsA(isA<ProductNoInternetConnection>()));
    });

    test('Should Throw Dio Erro type other  Product No Internet Connection',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          error: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllProducts(),
          throwsA(isA<ProductNoInternetConnection>()));
    });
  });
}
