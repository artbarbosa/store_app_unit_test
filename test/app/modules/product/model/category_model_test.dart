import 'package:flutter_test/flutter_test.dart';
import 'package:store_app_unit_test/app/modules/product/model/category_model.dart';

import '../../../../mocks/category_mock.dart';

void main() {
  final categoryModel = CategoryModel(category: "women's clothing");

  test('should return a valid model', () {
    final result = CategoryModel.fromJson(categoryMock);

    expect(result, isA<CategoryModel>());
    expect(result.category, categoryMock);
  });

  test('should return a json map containing the proper data', () {
    const expectedMap = '''{"category":"women's clothing"}''';

    final result = categoryModel.toJson();

    expect(result, expectedMap);
  });

}
