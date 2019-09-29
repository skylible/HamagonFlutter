import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';

class ResultList extends StatelessWidget {
  final List<Pest> results;

  const ResultList({Key key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hasil Pencarian"),
        ),
        body: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(results[index].name),
            );
          },
        ));
  }
}
