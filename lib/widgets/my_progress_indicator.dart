import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  final double containerSize;
  final double progressSize;

  const MyProgressIndicator({this.containerSize, this.progressSize = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      child: Center(
        child: SizedBox(
          width: progressSize,
          height: progressSize,
          child: Image.asset("assets/loading_img.gif"),
        ),
      ),
    );
  }
}
