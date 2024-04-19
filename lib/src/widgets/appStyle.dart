// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle appStyle(
  double size,
  Color color,
  FontWeight fw,
) {
  return TextStyle(
    fontFamily: 'Urbanist',
    fontSize: size.sp,
    color: color,
    fontWeight: fw,
  );
}
