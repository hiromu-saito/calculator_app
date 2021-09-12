import 'dart:async';

import 'package:flutter/material.dart';
import 'calculation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('電卓'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [TextField(), Keyboard()],
      ),
    ));
  }
}

class TextField extends StatefulWidget {
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  String _expression = '';

  void _UpdateText(String letter) {
    setState(() {
      if (letter == 'C')
        _expression = '';
      else if (letter == '=') {
        _expression = '';
        var ans = Calculator.execute();
        controller.sink.add(ans);
      } else {
        _expression += letter;
      }
    });
    void _RemoveOneletter() {
      setState(() {
        _expression = _expression.substring(0, _expression.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // any code
    return Expanded(
      flex: 2,
      child: Container(
          child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _expression,
              style: TextStyle(fontSize: 64.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.backspace_sharp),
                  onPressed: () {
                    setState(() {
                      _expression =
                          _expression.substring(0, _expression.length - 1);
                    });
                  },
                )),
          )
        ],
      )),
    );
  }

  static final controller = StreamController.broadcast();

  @override
  void initState() {
    controller.stream.listen((event) => _UpdateText(event));
    controller.stream.listen((event) => Calculator.getKey(event));
  }
}

// キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      // child: Center(
      child: Container(
        color: Color(0xff87cefa),
        child: GridView.count(
          padding: EdgeInsets.all(3),
          crossAxisCount: 4,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          children: [
            'C',
            '()',
            '%',
            '÷',
            '7',
            '8',
            '9',
            '×',
            '4',
            '5',
            '6',
            '-',
            '1',
            '2',
            '3',
            '+',
            '+/-',
            '0',
            '.',
            '=',
          ].map((key) {
            return GridTile(
              child: Button(
                key,
              ),
            );
          }).toList(),
        ),

        // ),
      ),
    );
  }
}

//　キーボタン
class Button extends StatelessWidget {
  final _key;
  Button(this._key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Center(
          child: Text(
            _key,
            style: TextStyle(
              fontSize: 32.0,
            ),
          ),
        ),
        onPressed: () {
          _TextFiledState.controller.sink.add(_key);
        },
      ),
    );
  }
}
