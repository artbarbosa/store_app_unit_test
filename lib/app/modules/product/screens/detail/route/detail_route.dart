import 'package:flutter/material.dart';
import '../container/detail_container.dart';
import 'detail_arguments.dart';

class DetailRoute extends StatelessWidget {
  const DetailRoute({Key? key, required this.arguments}) : super(key: key);
  final DetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    return DetailContainer(
      productId: arguments.productId,
    );
  }
}
