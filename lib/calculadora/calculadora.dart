import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String userInput = '';
  String answer = '';

  final List<String> buttons = [
    'AC',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  bool isOperator(String operator) {
    if (operator == '/' ||
        operator == 'x' ||
        operator == '-' ||
        operator == '+' ||
        operator == '=') {
      return true;
    }
    return false;
  }

  bool isRemove(String operator) {
    if (operator == 'AC' ||
        operator == '+/-' ||
        operator == '%' ||
        operator == 'DEL') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    if (eval.toString().length > 10) {
      answer = '${eval.toString().substring(0, 8)}...';
    } else if (eval.toString().contains(".0")) {
      answer = eval.toInt().toString();
    } else {
      answer = eval.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    answer,
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    switch (index) {
                      case 0:
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                        break;
                      case 1:
                        setState(() {
                          if (userInput.isNotEmpty) {
                            int number = int.parse(userInput);
                            userInput = (-number).toString();
                          }
                        });
                        break;
                      case 3:
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                        break;
                      case 18:
                        setState(() {
                          equalPressed();
                        });
                        break;
                      default:
                        setState(() {
                          userInput += buttons[index];
                        });
                        break;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (isOperator(buttons[index]))
                        ? Colors.orange
                        : (isRemove(buttons[index]))
                            ? const Color.fromRGBO(165, 165, 165, 1)
                            : const Color.fromRGBO(51, 51, 51, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    buttons[index],
                    style: TextStyle(
                      color: (isRemove(buttons[index]))
                          ? Colors.black
                          : Colors.white,
                      fontSize:
                          (buttons[index] == "DEL" || buttons[index] == "+/-")
                              ? 26
                              : 30,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
