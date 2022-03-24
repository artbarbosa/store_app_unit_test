import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app_unit_test/app/core/services/remote/dio_http_client_service.dart';
import 'package:store_app_unit_test/app/modules/product/errors/product_errors.dart';
import 'package:store_app_unit_test/app/modules/product/model/category_model.dart';
import 'package:store_app_unit_test/app/modules/product/model/product_model.dart';
import 'package:store_app_unit_test/app/modules/product/repository/product_repository_imp.dart';
import '../../../../mocks/response_categories_data_mock.dart';
import '../../../../mocks/response_porducts_by_category_data_mock.dart';
import '../../../../mocks/response_product_by_id_data_mock.dart';
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
          type: DioErrorType.connectTimeout,
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
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllProducts(),
          throwsA(isA<ProductNoInternetConnection>()));
    });

    test('Should Throw Dio Erro type cancel Product Error', () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.cancel,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllProducts(),
          throwsA(isA<ProductError>()));
    });

    test('Should Throw Dio Erro type sendTimeout Product Error', () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllProducts(),
          throwsA(isA<ProductError>()));
    });
  });

  group('ProductRepositoryImp - Get All Categories', () {
    test('Should return a list of Categories Model', () async {
      when(() => diohttpService.get(any())).thenAnswer((_) async => Response(
          data: responseJsonCategories,
          requestOptions: RequestOptions(path: '')));

      var result = await repositoryImp.getAllCategories();

      expect(result, isA<List<CategoryModel>>());
      expect(result.length, 4);
    });

    test(
        'Should Throw Dio Erro type connectTimeout Product Categories No Internet Connection ',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllCategories(),
          throwsA(isA<ProductCategoriesNoInternetConnection>()));
    });

    test(
        'Should Throw Dio Erro type other Product Categories No Internet Connection',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllCategories(),
          throwsA(isA<ProductCategoriesNoInternetConnection>()));
    });

    test('Should Throw Dio Erro type cancel Product Categories Error',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.cancel,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllCategories(),
          throwsA(isA<ProductCategoriesError>()));
    });
    test('Should Throw Dio Erro type sendTimeout Product Categories Error',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getAllCategories(),
          throwsA(isA<ProductCategoriesError>()));
    });
  });

  group('ProductRepositoryImp - Get Product By Id', () {
    test('Should return a Product Model', () async {
      when(() => diohttpService.get(any())).thenAnswer((_) async => Response(
          data: responseJsonProductById,
          requestOptions: RequestOptions(path: '')));

      var result = await repositoryImp.getProductById(1);

      expect(result, isA<ProductModel>());
      expect(result.id, 1);
      expect(result.title,
          "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops");
      expect(result.price, 109.95);
    });

    test(
        'Should Throw Dio Erro type connectTimeout Product Categories No Internet Connection ',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getProductById(1),
          throwsA(isA<ProductNoInternetConnection>()));
    });

    test(
        'Should Throw Dio Erro type other Product Categories No Internet Connection',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getProductById(1),
          throwsA(isA<ProductNoInternetConnection>()));
    });

    test('Should Throw Dio Erro type cancel Product Categories Error',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.cancel,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getProductById(1),
          throwsA(isA<ProductError>()));
    });

    test('Should Throw Dio Erro type sendTimeout Product Categories Error',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(() async => await repositoryImp.getProductById(1),
          throwsA(isA<ProductError>()));
    });
  });
  group('ProductRepositoryImp - Get Product By Category', () {
    test('Should return a List of Product Model', () async {
      when(() => diohttpService.get(any())).thenAnswer((_) async => Response(
          data: responeJsonProductByCategory,
          requestOptions: RequestOptions(path: '')));

      var result = await repositoryImp.getProductByCategory('electronics');

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 6);
    });

    test(
        'Should Throw Dio Erro type connectTimeout Products No Internet Connection ',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(
          () async => await repositoryImp.getProductByCategory('electronics'),
          throwsA(isA<ProductNoInternetConnection>()));
    });

    test('Should Throw Dio Erro type other Products No Internet Connection',
        () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(
          () async => await repositoryImp.getProductByCategory('electronics'),
          throwsA(isA<ProductNoInternetConnection>()));
    });

    test('Should Throw Dio Erro type cancel Product Error', () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.cancel,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(
          () async => await repositoryImp.getProductByCategory('electronics'),
          throwsA(isA<ProductError>()));
    });

    test('Should Throw Dio Erro type sendTimeout Product Error', () async {
      when(() => diohttpService.get(any())).thenThrow(
        DioError(
          type: DioErrorType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      expect(
          () async => await repositoryImp.getProductByCategory('electronics'),
          throwsA(isA<ProductError>()));
    });
  });
}
