import 'package:flutter/material.dart';
import '../../../errors/product_errors.dart';
import '../../../model/product_model.dart';
import '../../../repository/product_repository_interface.dart';
import '../states/detail_states.dart';

class DetailStore extends ValueNotifier<DetailState> {
  final IProductRepository repository;

  DetailStore({required this.repository}) : super(LoadingDetailState());

  late ProductModel product;

  String error = '';

  Future<void> _getProductById(int productId) async {
    try {
      product = await repository.getProductById(productId);
    } on ProductNoInternetConnection catch (e) {
      error = e.errorMessage;
    } on ProductError catch (e) {
      error = e.errorMessage;
    }
  }

  Future<void> fetchProductById(int productId) async {
    value = LoadingDetailState();
    try {
      await _getProductById(productId);
      value = SuccessDetailState(product: product);
    } catch (e) {
      value = ErrorDetailState(errorProduct: error);
    }
  }
}
