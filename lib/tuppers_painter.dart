import 'package:flutter/material.dart';

class Tuppers {
  static bool getBit(int x, int y, BigInt k) {
    var pow = BigInt.two.pow(17 * x + y % 17);
    var leftSide = (k + BigInt.from(y)) ~/ BigInt.from(17) ~/ pow % BigInt.two;
    return leftSide * BigInt.two > BigInt.one;
  }
}

class TuppersPainter extends CustomPainter {
  BigInt k;
  final _paint = Paint()..color = Colors.black;
  final _gridPaint = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  TuppersPainter(this.k);

  @override
  bool? hitTest(Offset position) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //find cell size
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 17),
      Paint()..color = Colors.white,
    );
    var cellSizeWidth = size.width / 106;
    var cellSizeHeight = size.height / 17;
    cellSizeHeight = cellSizeHeight.roundToDouble();
    cellSizeWidth = cellSizeWidth.roundToDouble();
    for (int x = 0; x < 106; x++) {
      for (int y = 0; y < 17; y++) {
        canvas.drawRect(
            Rect.fromLTWH(x * cellSizeWidth, y * cellSizeHeight, cellSizeWidth,
                cellSizeHeight),
            _gridPaint);
        if (Tuppers.getBit(x, y, k)) {
          // The 105 here flips the drawing because for the formular the top right corner is the start but
          // for Flutter its the top left
          canvas.drawRect(
              Rect.fromLTWH((105 - x) * cellSizeWidth, y * cellSizeHeight,
                  cellSizeWidth, cellSizeHeight),
              _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
