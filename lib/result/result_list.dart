import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';
import 'package:hamagon/result/result_detail.dart';

class ResultList extends StatelessWidget {
  final List<Pest> results;

  const ResultList({Key key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil Pencarian Hama"),
        backgroundColor: Color(0xff628336),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
            
          )
        )
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultDetail(
                            pest: results[index],
                          )));
            },
            child: Card(
              elevation: 3,
              child: ListTile(
                leading: Image.network(results[index].imageUrl),
                title: Text(results[index].name),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
