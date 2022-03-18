import 'package:dio/dio.dart';
import '../../../core/const/api_consts.dart';
import '../../../core/services/remote/http_client_service.dart';
import '../errors/product_errrors.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import 'product_repository_interface.dart';

class ProductRepositoryImp implements IProductRepository {
  final IHttpService httpService;

  ProductRepositoryImp({required this.httpService});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await httpService.get(ApiConst.allProductsURL());
      final list = response.data as List<dynamic>;
      return list.map((e) => ProductModel.fromJson(e)).toList();
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw ProductNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw ProductNoInternetConnection();
      } else {
        throw ProductError(
          stackTrace: s,
          label: 'ProductRepositoryImp-getAllProducts',
          exception: e.error,
          errorMessage: e.message,
        );
      }
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await httpService.get(ApiConst.allProductsURL());
      final list = response.data as List<dynamic>;
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw ProductCategoriesNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw ProductCategoriesNoInternetConnection();
      } else {
        throw ProductCategoriesError(
          stackTrace: s,
          label: 'ProductRepositoryImp-getAllCategories',
          exception: e.error,
          errorMessage: e.message,
        );
      }
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await httpService.get(ApiConst.productsByIdURL(id));
      return ProductModel.fromJson(response.data);
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw ProductNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw ProductNoInternetConnection();
      } else {
        throw ProductError(
          stackTrace: s,
          label: 'ProductRepositoryImp-getAllCategories',
          exception: e.error,
          errorMessage: e.message,
        );
      }
    }
  }

  @override
  Future<List<ProductModel>> getProductByCategory(String category) async {
    try {
      final response =
          await httpService.get(ApiConst.productsByCategoryURL(category));
      final list = response.data as List<dynamic>;
      return list.map((e) => ProductModel.fromJson(e)).toList();
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw ProductNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw ProductNoInternetConnection();
      } else {
        throw ProductError(
          stackTrace: s,
          label: 'ProductRepositoryImp-getAllCategories',
          exception: e.error,
          errorMessage: e.message,
        );
      }
    }
  }
}
