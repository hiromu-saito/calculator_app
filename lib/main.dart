import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _expression = '1+1';
  @override
  Widget build(BuildContext context) {
    // any code
    return Expanded(
      flex: 1,
      child: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            _expression,
            style: TextStyle(fontSize: 64.0),
          ),
        ),
      ),
    );
  }
}

// キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      // child: Center(
      child: Container(
        color: Color(0xff87cefa),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          children: [
            '7',
            '8',
            '9',
            '÷',
            '4',
            '5',
            '6',
            '×',
            '1',
            '2',
            '3',
            '-',
            'C',
            '0',
            '=',
            '+',
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
              fontSize: 46.0,
            ),
          ),
        ),
        onPressed: () {
          print('ボタン押下');
        },
      ),
    );
  }
}
