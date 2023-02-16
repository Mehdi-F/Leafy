// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class PaletteOrange{
  static const MaterialColor orangeToDark = const MaterialColor(
     0xffe99461,// 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffd28557),//10%
      100: const Color(0xffba764e),//20%
      200: const Color(0xffa36844),//30%
      300: const Color(0xff8c593a),//40%
      400: const Color(0xff754a31),//50%
      500: const Color(0xff5d3b27),//60%
      600: const Color(0xff462c1d),//70%
      700: const Color(0xff2f1e13),//80%
      800: const Color(0xff170f0a),//90%
      900: const Color(0xff000000),//100%
    },
  );

  static const MaterialColor orangeToWhite = const MaterialColor(
    0xffe99461,// 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffeb9f71),//10%
      100: const Color(0xffeda981),//20%
      200: const Color(0xfff0b490),//30%
      300: const Color(0xfff2bfa0),//40%
      400: const Color(0xfff4cab0),//50%
      500: const Color(0xfff6d4c0),//60%
      600: const Color(0xfff8dfd0),//70%
      700: const Color(0xfffbeadf),//80%
      800: const Color(0xfffdf4ef),//90%
      900: const Color(0xffffffff),//100%
    },
  );
}
