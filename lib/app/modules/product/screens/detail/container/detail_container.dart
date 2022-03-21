import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../detail_page.dart';
import '../states/detail_states.dart';
import '../store/detail_store.dart';

class DetailContainer extends StatefulWidget {
  const DetailContainer({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final int productId;
  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<DetailStore>().fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<DetailStore>();
    final state = store.value;
    Widget? child;

    if (state is LoadingDetailState) {
      child = const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is SuccessDetailState) {
      child = Text(state.product.title);
    }

    if (state is ErrorDetailState) {
      child = SliverToBoxAdapter(
        child: Center(
          child: Text(state.errorProduct),
        ),
      );
    }

    return DetailPage(child: child ?? Container());
  }
}
