import 'package:flutter/material.dart';

import 'calculadora/calculadora.dart'; //Esta libreria siempre tiene que estar.

void main() => runApp(const MyApp()); //

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Desde Cero',
      home: Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}