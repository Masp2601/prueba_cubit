import 'package:flutter/material.dart';
import 'package:prueba_cubit/src/widgets/reusable_text.dart';

class CustomOtlnBtn extends StatelessWidget {
  const CustomOtlnBtn(
      {super.key,
      this.onTap,
      required this.width,
      required this.height,
      this.color1,
      required this.color,
      required this.text});

  final void Function()? onTap;
  final double width;
  final double height;
  final Color? color1;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color1,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1, color: color)),
        child: Center(
          child: ReusableText(
            text: text,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
