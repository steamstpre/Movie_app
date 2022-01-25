import 'package:flutter/material.dart';

class Refresh_widget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;

  const Refresh_widget({Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  _Refresh_widgetState createState() => _Refresh_widgetState();
}

class _Refresh_widgetState extends State<Refresh_widget> {
  @override
  Widget build(BuildContext context) => buildAndroidList();

  Widget buildAndroidList() =>
      RefreshIndicator(onRefresh: widget.onRefresh, child: widget.child);
}
