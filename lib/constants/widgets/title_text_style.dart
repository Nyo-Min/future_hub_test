import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';


class TitleTextStyle extends StatelessWidget {
  const TitleTextStyle(
      {super.key,
        required this.titleText,
        required this.titleStyle,
        this.titleAlign,
      this.titleMaxLine,});

  final String titleText;
  final TextStyle titleStyle;
  final TextAlign? titleAlign;
  final int? titleMaxLine;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      titleText,
      style: titleStyle,
      textAlign: titleAlign,
      overflow: TextOverflow.ellipsis,
      minFontSize: 16,
      maxFontSize: 16,
      maxLines: titleMaxLine ?? 2,
    );
  }
}