// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class PaletteBlue{
  static const MaterialColor blueToDark = const MaterialColor(
     0xff61b9e9,// 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff57a7d2),//10%
      100: const Color(0xff4e94ba),//20%
      200: const Color(0xff4482a3),//30%
      300: const Color(0xff3a6f8c),//40%
      400: const Color(0xff315d75),//50%
      500: const Color(0xff274a5d),//60%
      600: const Color(0xff1d3746),//70%
      700: const Color(0xff13252f),//80%
      800: const Color(0xff0a1217),//90%
      900: const Color(0xff000000),//100%
    },
  );

  static const MaterialColor blueToWhite = const MaterialColor(
    0xff61b9e9,// 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff71c0eb),//10%
      100: const Color(0xff81c7ed),//20%
      200: const Color(0xff90cef0),//30%
      300: const Color(0xffa0d5f2),//40%
      400: const Color(0xffb0dcf4),//50%
      500: const Color(0xffc0e3f6),//60%
      600: const Color(0xffd0eaf8),//70%
      700: const Color(0xffdff1fb),//80%
      800: const Color(0xffeff8fd),//90%
      900: const Color(0xffffffff),//100%
    },
  );
}
