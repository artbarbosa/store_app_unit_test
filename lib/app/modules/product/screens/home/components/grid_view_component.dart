import 'package:flutter/material.dart';

import '../../../model/product_model.dart';
import '../../detail/route/detail_arguments.dart';

class GridViewComponent extends StatelessWidget {
  const GridViewComponent(
      {Key? key,
      required this.products,
      required this.currentWidth,
      required this.currentHeight})
      : super(key: key);
  final List<ProductModel> products;
  final double currentWidth;
  final double currentHeight;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, idx) {
          return GridTile(
              child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              '/detail',
              arguments: DetailArguments(
                productId: products[idx].id,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.03,
                  color: Colors.black,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: currentHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        products[idx].image,
                        fit: BoxFit.contain,
                        height: currentHeight * 0.2,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text.rich(
                      TextSpan(
                        style:
                            const TextStyle(fontFamily: 'Rocko', fontSize: 13),
                        text: products[idx].title,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
        childCount: products.length,
      ),
    );
  }
}
