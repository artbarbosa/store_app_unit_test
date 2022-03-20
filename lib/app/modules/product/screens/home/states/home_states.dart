import '../../../model/category_model.dart';
import '../../../model/product_model.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  SuccessHomeState({
    required this.products,
    required this.categories,
  });
}

class ErrorHomeState extends HomeState {
  final String errorProduct;
  final String errorCategory;
  ErrorHomeState({
    required this.errorProduct,
    required this.errorCategory,
  });
}
