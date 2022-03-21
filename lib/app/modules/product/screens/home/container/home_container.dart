import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app_unit_test/app/modules/product/screens/detail/route/detail_arguments.dart';
import '../components/grid_view_component.dart';
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
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

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
      child = GridViewComponent(
        currentHeight: currentHeight,
        currentWidth: currentWidth,
        products: state.products,
      );
    }

    if (state is ErrorHomeState) {
      child = SliverToBoxAdapter(
        child: Center(
          child: Text(state.errorProduct),
        ),
      );
    }

    return HomePage(child: child ?? Container());
  }
}
