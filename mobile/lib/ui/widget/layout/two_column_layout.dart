import 'package:flutter/material.dart';

class ColumnsLayout<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final int columns;

  const ColumnsLayout({
    Key key,
    this.items,
    this.itemBuilder,
    this.columns = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: items.map((e) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / columns,
          child: itemBuilder.call(e),
        );
      }).toList(),
    );
  }
}
