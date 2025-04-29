import 'package:flutter/widgets.dart';

class AppTextStyles {
  AppTextStyles._();

  // Texto da Splash Screen
  static const TextStyle textoGrande = TextStyle(
    fontSize: 46.0, 
    fontFamily: 'Montserrat'
    // A propriedade de cor é adicionada com .copyWith(color: cor) na instância
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24.0,
    fontWeight: FontWeight.bold
  );

  static const TextStyle p = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
  );
}