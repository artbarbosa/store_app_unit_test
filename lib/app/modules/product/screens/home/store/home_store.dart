import 'package:flutter/material.dart';

import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import '../../../repository/product_repository_interface.dart';
import '../states/home_states.dart';

class HomeStore extends ValueNotifier<HomeState> {
  final IProductRepository repository;

  HomeStore({required this.repository}) : super(LoadingHomeState());




  Future fetchAllProducts() async {
    value = LoadingHomeState();
    try {
      final products = await repository.getAllProducts();
      final categories = await repository.getAllCategories();
      value = SuccessHomeState(products: products, categories: categories);
    } catch (e) {
      value = ErrorHomeState(error: e.toString());
    }
  }

    Future fetchProductsByCategoy(String category) async {
    value = LoadingHomeState();
    try {
      final products = await repository.getProductByCategory(category);
    } catch (e) {
      value = ErrorHomeState(error: e.toString());
    }
  }
}
