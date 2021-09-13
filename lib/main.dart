import 'dart:async';

import 'package:calculator_app/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('電卓'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [TextField(), Keyboard()],
        ),
      ),
    ));
  }
}

class TextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
          child: Consumer<MainModel>(builder: (context, model, child) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                model.expression,
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
                    model.removeOneLetter();
                  },
                ),
              ),
            ),
          ],
        );
      })),
    );
  }
}

// キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
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
              ButtonProperty('7', Colors.black, false),
              ButtonProperty('8', Colors.black, false),
              ButtonProperty('9', Colors.black, false),
              ButtonProperty('÷', Colors.green, model.isAbleOperator()),
              ButtonProperty('4', Colors.black, false),
              ButtonProperty('5', Colors.black, false),
              ButtonProperty('6', Colors.black, false),
              ButtonProperty('×', Colors.green, model.isAbleOperator()),
              ButtonProperty('1', Colors.black, false),
              ButtonProperty('2', Colors.black, false),
              ButtonProperty('3', Colors.black, false),
              ButtonProperty('-', Colors.green, model.isAbleOperator()),
              ButtonProperty('C', Colors.red, false),
              ButtonProperty('0', Colors.black, model.expression.isEmpty),
              ButtonProperty('=', Colors.red, model.isAbleOperator()),
              ButtonProperty('+', Colors.green, model.isAbleOperator()),
            ].map((buttonProperty) {
              return GridTile(
                child: Button(buttonProperty.key, buttonProperty.color,
                    buttonProperty.disable),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class ButtonProperty {
  String _key;
  Color _color;
  bool _disable;
  String get key => _key;
  Color get color => _color;
  bool get disable => _disable;

  ButtonProperty(this._key, this._color, this._disable);
}

//　キーボタン
class Button extends StatelessWidget {
  final String _key;
  final _color;
  final _disable;
  Button(this._key, this._color, this._disable);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return TextButton(
        child: Text(
          _key,
          style: TextStyle(
            fontSize: 20.0,
            color: _color,
          ),
        ),
        onPressed: () {
          if (!_disable) {
            model.updateText(_key);
          }
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          fixedSize: Size(10, 10),
          backgroundColor: Colors.grey[200],
        ),
      );
    });
  }
}
