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

  void _updateText(String letter) {
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
      flex: 1,
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
            padding: EdgeInsets.only(top: 30),
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
              ),
            ),
          ),
        ],
      )),
    );
  }

  static final controller = StreamController.broadcast();

  @override
  void initState() {
    controller.stream.listen((event) => _updateText(event));
    controller.stream.listen((event) => Calculator.getKey(event));
  }
}

// キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        // color: Color(0xff87cefa),
        child: GridView.count(
          padding: EdgeInsets.all(3),
          crossAxisCount: 4,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          children: [
            ButtonProperty('C', Colors.red),
            ButtonProperty('()', Colors.green),
            ButtonProperty('%', Colors.green),
            ButtonProperty('÷', Colors.green),
            ButtonProperty('7', Colors.black),
            ButtonProperty('8', Colors.black),
            ButtonProperty('9', Colors.black),
            ButtonProperty('×', Colors.green),
            ButtonProperty('4', Colors.black),
            ButtonProperty('5', Colors.black),
            ButtonProperty('6', Colors.black),
            ButtonProperty('-', Colors.green),
            ButtonProperty('1', Colors.black),
            ButtonProperty('2', Colors.black),
            ButtonProperty('3', Colors.black),
            ButtonProperty('+', Colors.green),
            ButtonProperty('+/-', Colors.black),
            ButtonProperty('0', Colors.black),
            ButtonProperty('.', Colors.black),
            ButtonProperty('=', Colors.green),
          ].map((buttonProperty) {
            return GridTile(
              child: Button(buttonProperty.key, buttonProperty.color),
            );
          }).toList(),
        ),

        // ),
      ),
    );
  }
}

class ButtonProperty {
  String _key;
  Color _color;
  String get key => _key;
  Color get color => _color;

  ButtonProperty(this._key, this._color);
}

//　キーボタン
class Button extends StatelessWidget {
  final _key;
  final _color;
  Button(this._key, this._color);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        _key,
        style: TextStyle(
          fontSize: 20.0,
          color: _color,
        ),
      ),
      onPressed: () {
        _TextFiledState.controller.sink.add(_key);
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        fixedSize: Size(10, 10),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
