import '../../../core/error/failure.dart';

abstract class NoInternetConnection extends Failure {
  NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class ProductNoInternetConnection extends NoInternetConnection {}

class ProductError extends Failure {
  ProductError({
    StackTrace? stackTrace,
    required String? label,
    required dynamic exception,
    required String errorMessage,
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class ProductCategoriesNoInternetConnection extends NoInternetConnection {}

class ProductCategoriesError extends Failure {
  ProductCategoriesError({
    StackTrace? stackTrace,
    required String label,
    required dynamic exception,
    required String errorMessage,
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}
