import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'StoreZ',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Vectory', fontSize: 24),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
