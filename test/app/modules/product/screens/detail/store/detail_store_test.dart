import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app_unit_test/app/modules/product/errors/product_errrors.dart';
import 'package:store_app_unit_test/app/modules/product/model/product_model.dart';
import 'package:store_app_unit_test/app/modules/product/repository/product_repository_interface.dart';
import 'package:store_app_unit_test/app/modules/product/screens/detail/states/detail_states.dart';
import 'package:store_app_unit_test/app/modules/product/screens/detail/store/detail_store.dart';

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  late DetailStore store;
  late ProductRepositoryMock repository;

  final ProductModel productModel = ProductModel(
      id: 1,
      title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      price: 109.95,
      description:
          "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      category: "men's clothing",
      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      rating: Rating(rate: 3.9, count: 120));

  group('Detail Store fetch Products - repoistory get Product By Id ', () {
    setUp(() {
      repository = ProductRepositoryMock();
      repository = ProductRepositoryMock();
      store = DetailStore(repository: repository);
    });

    test('_getProductById Should return ProductModel', () async {
      when(() => repository.getProductById(1))
          .thenAnswer((_) async => productModel);

      await store.fetchProductById(1);

      expect(store.value, isA<SuccessDetailState>());
      expect(store.product.id, 1);
    });

    test(
        '_getProductById Should return ErrorDetailState - ProductNoInternetConnection',
        () async {
      when(() => repository.getProductById(1))
          .thenThrow(ProductNoInternetConnection());

      await store.fetchProductById(1);

      expect(store.value, isA<ErrorDetailState>());
      expect(store.error.isNotEmpty, true);
    });
    test('_getProductById Should return ErrorDetailState  - ProductError',
        () async {
      when(() => repository.getProductById(1)).thenThrow(ProductError(
        errorMessage: 'test',
        exception: 'test',
        label: 'test',
      ));

      await store.fetchProductById(1);

      expect(store.value, isA<ErrorDetailState>());
      expect(store.error.isNotEmpty, true);
    });
  });
}
