import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key, this.dashSpace = 4, this.dashWidth = 6, this.height = 1, this.color = Colors.grey});

  final double dashSpace;
  final double dashWidth;
  final double height;

  final Color color;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(dashCount, (_) {
          return SizedBox(
            height: height,
            width: dashWidth,
            child: const DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
          );
        }),
      );
    },
  );
}
