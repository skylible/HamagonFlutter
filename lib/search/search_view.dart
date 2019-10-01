import 'package:flutter/material.dart';
import 'package:hamagon/detail_search/detail_main.dart';
import 'package:hamagon/image_search/main.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(12),
            color: Colors.green,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(40.0),
                          ),
                        ),
                        hintText: 'Enter a search term'),
                  ),
                ),
              ],
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainImage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.camera_alt),
                    color: Colors.teal[100],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailMain()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.list),
                    color: Colors.teal[100],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
