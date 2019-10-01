import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';

class ResultDetail extends StatelessWidget {
  final Pest pest;

  const ResultDetail({Key key, this.pest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Hama"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.network(pest.imageUrl),
              ),
              Container(
                child: Text(pest.name),
              )
            ],
          ),
        ));
  }
}
