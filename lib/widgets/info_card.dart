import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final double height, width;
  final Widget child;

  const InfoCard({
    super.key,
    required this.height,
    required this.width,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}