import 'package:flutter/material.dart';

enum BadgeSize { small, medium, large }

class Badge extends StatelessWidget {
  final String text;
  final BadgeSize size;
  Badge(this.text, {this.size});
  @override
  Widget build(BuildContext context) {
    return new Text(
      this.text,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
