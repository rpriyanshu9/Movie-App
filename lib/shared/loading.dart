import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
