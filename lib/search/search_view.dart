import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.green,
            child: Column(
              children: <Widget>[],
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('He\'d have you all unravel at the'),
                  color: Colors.teal[100],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Heed not the rabble'),
                  color: Colors.teal[200],
                ),
              ],
            ))
      ],
    );
  }
}
