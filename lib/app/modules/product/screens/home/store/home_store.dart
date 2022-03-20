import 'package:flutter/material.dart';
import '../../../errors/product_errrors.dart';
import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import '../../../repository/product_repository_interface.dart';
import '../states/home_states.dart';

class HomeStore extends ValueNotifier<HomeState> {
  final IProductRepository repository;

  HomeStore({required this.repository}) : super(LoadingHomeState()) {
    _getAllCategories();
  }

  List<CategoryModel> categories = [];

  List<ProductModel> products = [];

  String category = '';

  String error = '';

  Future<void> _getAllProducts() async {
    try {
      products = await repository.getAllProducts();
    } on ProductNoInternetConnection catch (e) {
      error = e.errorMessage;
    } on ProductError catch (e) {
      error = e.errorMessage;
    }
  }

  Future<void> _getProductsByCategory() async {
    try {
      products = await repository.getProductByCategory(category);
    } on ProductNoInternetConnection catch (e) {
      error = e.errorMessage;
    } on ProductError catch (e) {
      error = e.errorMessage;
    }
  }

  Future<void> _getAllCategories() async {
    try {
      categories = await repository.getAllCategories();
    } on ProductCategoriesNoInternetConnection catch (e) {
      error = e.errorMessage;
    } on ProductCategoriesError catch (e) {
      error = e.errorMessage;
    }
  }

  Future<void> fetchProducts(String categorySearch) async {
    value = LoadingHomeState();
    category = categorySearch;
    try {
      if (category == '' || category.isEmpty) {
        await _getAllProducts();
      } else {
        await _getProductsByCategory();
      }
      value = SuccessHomeState(products: products, categories: categories);
    } catch (e) {
      value = ErrorHomeState(error: error);
    }
  }
}
