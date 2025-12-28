import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double dashSpace;
  final double dashWidth;
  final double height;
  final Color color;

  const DashedDivider({
    super.key,
    this.dashSpace = 4,
    this.dashWidth = 6,
    this.height = 1,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              height: height,
              width: dashWidth,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}