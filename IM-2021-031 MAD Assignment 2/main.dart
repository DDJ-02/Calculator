// IM/2021/031 - Dinan Jayasuriya
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0'; // Display current value/result
  String operation = ''; // Display full operation
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '0';
  String opr = '';
  String preOpr = '';
  bool calculationComplete = false; // Flag to track if "=" was pressed

  // Button Widget
  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
        shape:  CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: btncolor,
      ),
      child: Text(
        btntxt,
        style: TextStyle(fontSize: 20, color: txtcolor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 228, 255),
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: const Color.fromARGB(255, 179, 179, 179),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Display Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          operation,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          text,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('√', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('7', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('8', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('9', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('x', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('4', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('5', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('6', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('-', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('1', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('2', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('3', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('+', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('0', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('.', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('/', Colors.amber[700] ?? Colors.amber, Colors.white),
                calcButton('=', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Calculator Logic
  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      operation = '';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
      calculationComplete = false;
    } else if (btnText == '+/-') {
      if (result.isNotEmpty) {
        // Toggle the sign of the current number
        if (result.startsWith('-')) {
          result = result.substring(1); // Remove the negative sign
        } else {
          result = '-$result'; // Add the negative sign
        }// Update the operation display with the new value
        if (operation.isNotEmpty) {
          // Remove the last number and append the updated result
          operation = operation.substring(0, operation.length - finalResult.length) + result;
        } else {
          operation = result; // If operation is empty, set it to the result
        }
        finalResult = result;
      }
    }
    /*else if (btnText == 'C') {
      text = '0';
      result = '';
      finalResult = '0';
    }*/ else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (calculationComplete && btnText != '=') {
        numOne = double.parse(finalResult);
        result = '';
        calculationComplete = false;
      }

      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
      if (btnText != '=') {
        operation += ' $btnText';
      } else {
        operation += ' $btnText $finalResult';
        calculationComplete = true;
      }
    } 
    else if (btnText == '%') {
      if (numOne != 0 && opr.isNotEmpty) {
        // Percentage relative to numOne
        result = ((numOne * double.parse(result)) / 100).toString();
      } else {
        // Standalone percentage (e.g., 5% = 0.05)
        result = (double.parse(result) / 100).toString();
      }
      finalResult = doesContainDecimal(result);
      operation += ' %';
    }
    else if (btnText == '.') {
      if (!result.contains('.')) {
        result += '.';
        operation += '.';
      }
      finalResult = result;
    } else if (btnText == '√') {
        if (result.isNotEmpty) {
          double numberToSquareRoot = double.parse(result);

          if (numberToSquareRoot < 0) {
            text = "Error"; // Square root of a negative number is undefined
            operation += ' √(Error)';
            finalResult = text;
          } else {
            result = sqrt(numberToSquareRoot).toStringAsFixed(2);
            finalResult = result;
            // Update the operation to reflect the square root operation
            operation += '√';
          }
        }
    }
    else {
      if (calculationComplete) {
        text = '0';
        operation = '';
        result = '';
        finalResult = '';
        calculationComplete = false;
      }
      result += btnText;
      finalResult = result;
      operation += btnText;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toStringAsFixed(2);
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toStringAsFixed(2);
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toStringAsFixed(2);
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) return "Error";
    result = (numOne / numTwo).toStringAsFixed(8);
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (int.parse(splitDecimal[1]) == 0) {
        return splitDecimal[0];
      }
    }
    return result;
  }
}
