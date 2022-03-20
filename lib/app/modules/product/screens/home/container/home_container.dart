import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app_unit_test/app/modules/product/screens/detail/route/detail_arguments.dart';
import '../home_page.dart';
import '../states/home_states.dart';
import '../store/home_store.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<HomeStore>().fetchProducts('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<HomeStore>();
    final state = store.value;
    Widget? child;

    if (state is LoadingHomeState) {
      child = const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is SuccessHomeState) {
      child = SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, idx) {
            return TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/detail',
                  arguments: DetailArguments(
                    productId: state.products[idx].id,
                  ),
                );
              },
              child: Text(state.products[idx].title),
            );
          },
          childCount: state.products.length,
        ),
      );
    }

    if (state is ErrorHomeState) {
      child = SliverToBoxAdapter(
        child: Center(
          child: Text(state.error),
        ),
      );
    }

    return HomePage(child: child ?? Container());
  }
}
