import 'package:flutter/material.dart';

class Refresh_widget extends StatelessWidget {
  final Widget child;
  final Future Function() onRefresh;

  const Refresh_widget({Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildList();

  Widget buildList() => RefreshIndicator(onRefresh: onRefresh, child: child);
}
