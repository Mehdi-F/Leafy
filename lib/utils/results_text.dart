import 'package:flutter/material.dart';
import 'package:leafy/utils/palette_orange.dart';


class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.title,
      required this.value,
      required this.height,
      required this.weight})
      : super(key: key);

  final String title;
  final double height;
  final String value;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: PaletteOrange.orangeToDark,
              fontSize: height,
              fontWeight: weight,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              color: PaletteOrange.orangeToDark,
              fontSize: height*0.5,
            ),
          ),
        )
      ],
    );
  }
}
