class Calculator {
  static const c_op = ['+', '-', '×', '÷'];

  static String execute(String expression) {
    List<String> letters = expression.split('');
    String buffer = '';
    List<String> ops = <String>[];
    List<double> numbers = <double>[];

    for (var letter in letters) {
      if (c_op.contains(letter)) {
        ops.add(letter);
        if (buffer != '') {
          numbers.add(double.parse(buffer));
          buffer = '';
        }
      } else {
        buffer += letter;
      }
    }
    numbers.add(double.parse(buffer));

    double _result = numbers[0];
    for (int i = 1; i < numbers.length; i++) {
      _result = calculate(_result, numbers[i], ops[i - 1]);
    }
    var result = _result.ceil().toString();
    return result.length <= 10 ? result : 'error';
  }

  static double calculate(double num1, double num2, String operand) {
    switch (operand) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '×':
        return num1 * num2;
      case '÷':
        return num1 / num2;
      default:
        return 0;
    }
  }
}
