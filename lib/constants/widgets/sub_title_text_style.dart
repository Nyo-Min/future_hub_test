import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';


class SubTitleTextStyle extends StatelessWidget {
  const SubTitleTextStyle(
      {super.key,
        required this.subTitleText,
        required this.subTitleStyle,
        this.subTitleAlign,
        this.subMaxLine,
      });

  final String subTitleText;
  final TextStyle subTitleStyle;
  final TextAlign? subTitleAlign;
  final int? subMaxLine;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      subTitleText,
      style: subTitleStyle,
      textAlign: subTitleAlign,
      overflow: TextOverflow.ellipsis,
      minFontSize: 14,
      maxFontSize: 14,
      maxLines: subMaxLine ?? 2,
    );
  }
}