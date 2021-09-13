import 'package:flutter/cupertino.dart';
import 'calculation.dart';

class MainModel extends ChangeNotifier {
  String expression = '';

  void updateText(String letter) {
    if (expression.length >= 10) {
      return;
    }
    switch (letter) {
      case 'C':
        expression = '';
        break;
      case '=':
        expression = Calculator.execute(expression);
        break;
      default:
        expression += letter;
    }
    notifyListeners();
  }

  void removeOneLetter() {
    if (expression == '') {
      return;
    }
    expression = expression.substring(0, expression.length - 1);
    notifyListeners();
  }

  bool isAbleOperator() {
    if (expression.length == 0) {
      return true;
    }
    return Calculator.c_op.contains(expression[expression.length - 1]);
  }
}
