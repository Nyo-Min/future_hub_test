import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class HeaderTextStyle extends StatelessWidget {
  const HeaderTextStyle({
    super.key,
    required this.headerText,
    required this.headerStyle,
    this.headerAlign
  });

  final String headerText;
  final TextStyle headerStyle;
  final TextAlign? headerAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      headerText,
      style: headerStyle,
      textAlign: headerAlign,
      overflow: TextOverflow.ellipsis,
      minFontSize: 18,
      maxFontSize: 18,
      maxLines: 2,
    );
  }
}