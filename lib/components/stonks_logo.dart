import 'package:flutter/material.dart';

class StonksLogo extends StatelessWidget {
  const StonksLogo({
    Key? key,
    required Color color,
    required double size,
  })  : _color = color,
        _size = size,
        super(key: key);

  final Color _color;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_size / 20),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: _size / (100.0 / 7.0), color: _color),
              bottom: BorderSide(width: _size / (100.0 / 7.0), color: _color),
            ),
          ),
          child: Icon(
            Icons.trending_up,
            color: _color,
            size: _size,
            semanticLabel: 'Stonks Logo',
          ),
        ),
      ],
    );
  }
}
