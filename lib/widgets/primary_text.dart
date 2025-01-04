import 'package:flutter/material.dart';

import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';
import '../resource/app_font.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight? weight;
  const PrimaryText({super.key,required this.text,this.size = AppDimen.textSize16,this.color = AppColors.textColor,this.weight = AppFont.regular});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontFamily: AppFont.font,
      ),
    );
  }
}