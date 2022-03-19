class ApiConst {
  static String allProductsURL() => 'https://fakestoreapi.com/products';
  static String allCategoriesURL() => 'https://fakestoreapi.com/products/categories';
  static String productsByIdURL(int id) =>
      'https://fakestoreapi.com/products/$id';
  static String productsByCategoryURL(String category) =>
      'https://fakestoreapi.com/products/category/$category';
}
