import '../../../model/product_model.dart';

abstract class DetailState {}

class InitialDetailState extends DetailState {}

class LoadingDetailState extends DetailState {}

class SuccessDetailState extends DetailState {
  final ProductModel product;
  SuccessDetailState({
    required this.product,
  });
}

class ErrorDetailState extends DetailState {
  final String error;
  ErrorDetailState({
    required this.error,
  });
}
