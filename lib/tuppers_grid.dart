import 'package:flutter/material.dart';
import 'package:tuppers/tuppers_painter.dart';

class TuppersGrid extends StatefulWidget {
  final Size girdSize;
  final BigInt currentK;
  final TextEditingController controller;

  const TuppersGrid({
    required this.controller,
    required this.currentK,
    required this.girdSize,
    Key? key,
  }) : super(key: key);

  @override
  State<TuppersGrid> createState() => _TuppersGridState();
}

class _TuppersGridState extends State<TuppersGrid> {
  late BigInt currentK;
  var grid = List.generate(106, (_) => List.filled(17, false, growable: false));

  @override
  void initState() {
    currentK = widget.currentK;
    super.initState();
    widget.controller.addListener(() {
      try {
        final text = widget.controller.text;
        if (text.isEmpty) {
          currentK = BigInt.zero;
        } else {
          currentK = BigInt.parse(text);
        }
        if (currentK.isNegative == false) {
          setState(() {});
        } else {
          throw 'Nope';
        }
      } catch (e) {
        //We dont care
      }
    });
  }

  void _updateGrid() {
    for (int x = 0; x < 106; x++) {
      for (int y = 0; y < 17; y++) {
        grid[x][y] = Tuppers.getBit(x, y, currentK);
      }
    }
  }

  String _getBinaryString() {
    final builder = StringBuffer();
    for (int x = 0; x < 106; x++) {
      for (int y = 0; y < 17; y++) {
        if (grid[x][y]) {
          builder.write("1");
        } else {
          builder.write("0");
        }
      }
    }
    return builder.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final xSize = widget.girdSize.width ~/ 106;
        final ySize = widget.girdSize.height ~/ 17;
        final x = details.localPosition.dx ~/ xSize;
        final y = details.localPosition.dy ~/ ySize;
        _updateGrid();
        debugPrint("($x/$y): is ${grid[x.toInt()][y.toInt()]}");
        grid[105 - x.toInt()][y.toInt()] = !grid[105 - x.toInt()][y.toInt()];
        final binString = _getBinaryString();

        setState(() {
          currentK =
              BigInt.parse(binString.split('').reversed.join(), radix: 2) *
                  BigInt.from(17);
          widget.controller.text = currentK.toString();
        });
      },
      child: CustomPaint(
        painter: TuppersPainter(
          currentK,
        ),
        size: widget.girdSize,
        child: SizedBox.fromSize(
          size: widget.girdSize,
        ),
      ),
    );
  }
}
