import 'package:store_app_unit_test/app/modules/product/model/category_model.dart';
import 'package:store_app_unit_test/app/modules/product/model/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<List<CategoryModel>> getAllCategories();
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductByCategory(String category);
}
