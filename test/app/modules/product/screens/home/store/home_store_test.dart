import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app_unit_test/app/modules/product/errors/product_errors.dart';
import 'package:store_app_unit_test/app/modules/product/model/category_model.dart';
import 'package:store_app_unit_test/app/modules/product/model/product_model.dart';
import 'package:store_app_unit_test/app/modules/product/repository/product_repository_interface.dart';
import 'package:store_app_unit_test/app/modules/product/screens/home/states/home_states.dart';
import 'package:store_app_unit_test/app/modules/product/screens/home/store/home_store.dart';

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  late HomeStore store;
  late ProductRepositoryMock repository;

  final List<ProductModel> listProducts = [
    ProductModel(
        id: 1,
        title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
        price: 109.95,
        description:
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: Rating(rate: 3.9, count: 120))
  ];

  final List<CategoryModel> categories = [
    CategoryModel(category: "men's clothing")
  ];

  group('Home Store fetch Products - repoistory get all products ', () {
    setUp(() {
      repository = ProductRepositoryMock();
      repository = ProductRepositoryMock();
      when(() => repository.getAllCategories())
          .thenAnswer((_) async => categories);
      store = HomeStore(repository: repository);
    });

    test('_getAllProducts Should return List ProductModel', () async {
      when(() => repository.getAllProducts())
          .thenAnswer((_) async => listProducts);

      await store.fetchProducts('');

      expect(store.value, isA<SuccessHomeState>());
      expect(store.products[0].id, 1);
      expect(store.products.length, 1);
    });

    test(
        '_getAllProducts Should return ErrorHomeState - ProductNoInternetConnection',
        () async {
      when(() => repository.getAllProducts())
          .thenThrow(ProductNoInternetConnection());

      await store.fetchProducts('');

      expect(store.value, isA<ErrorHomeState>());
      expect(store.errorProduct.isNotEmpty, true);
    });
    test('_getAllProducts Should return ErrorHomeState  - ProductError',
        () async {
      when(() => repository.getAllProducts()).thenThrow(ProductError(
        errorMessage: 'test',
        exception: 'test',
        label: 'test',
      ));

      await store.fetchProducts('');

      expect(store.value, isA<ErrorHomeState>());
      expect(store.errorProduct.isNotEmpty, true);
    });

    test('_getProductsByCategory Should return List ProductModel', () async {
      when(() => repository.getProductByCategory("men's clothing"))
          .thenAnswer((_) async => listProducts);

      await store.fetchProducts("men's clothing");

      expect(store.value, isA<SuccessHomeState>());
      expect(store.products[0].id, 1);
      expect(store.products.length, 1);
    });

    test(
        '_getProductsByCategory Should return ErrorHomeState - ProductNoInternetConnection',
        () async {
      when(() => repository.getProductByCategory("men's clothing"))
          .thenThrow(ProductNoInternetConnection());

      await store.fetchProducts("men's clothing");

      expect(store.value, isA<ErrorHomeState>());
      expect(store.errorProduct.isNotEmpty, true);
    });

    test('_getProductsByCategory Should return ErrorHomeState  - ProductError',
        () async {
      when(() => repository.getProductByCategory("men's clothing"))
          .thenThrow(ProductError(
        errorMessage: 'test',
        exception: 'test',
        label: 'test',
      ));

      await store.fetchProducts("men's clothing");

      expect(store.value, isA<ErrorHomeState>());
      expect(store.errorProduct.isNotEmpty, true);
    });
  });
}
