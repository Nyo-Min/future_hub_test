import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';


class LabelTextStyle extends StatelessWidget {
  const LabelTextStyle(
      {super.key,
        required this.labelText,
        required this.labelStyle,
        this.labelAlign,
        this.labelMaxLine
      });

  final String labelText;
  final TextStyle labelStyle;
  final TextAlign? labelAlign;
  final int? labelMaxLine;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      labelText,
      style: labelStyle,
      textAlign: labelAlign,
      overflow: TextOverflow.ellipsis,
      maxFontSize: 12,
      minFontSize: 12,
      maxLines: labelMaxLine ?? 2,
    );
  }
}