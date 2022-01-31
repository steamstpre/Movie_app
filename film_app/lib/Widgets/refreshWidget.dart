import 'package:flutter/material.dart';

class RefreshWidget extends StatelessWidget {
  final Widget child;
  final Future Function() onRefresh;

  const RefreshWidget({Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildList();

  Widget buildList() => RefreshIndicator(onRefresh: onRefresh, child: child);
}
