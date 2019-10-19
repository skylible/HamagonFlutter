import 'package:flutter/material.dart';
import 'package:hamagon/detail_search/detail_main.dart';
import 'package:hamagon/image_search/main.dart';
import 'package:hamagon/model/pest_repo.dart';
import 'package:hamagon/result/result_list.dart';

class SearchView extends StatelessWidget {
  PestRepo pestRepo = PestRepo();
  TextEditingController _name = TextEditingController();
  BuildContext context;

  void _searchName({BuildContext context}) {
    List<Pest> pests = pestRepo.searchName(name: _name.text);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ResultList(results: pests)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/farmland.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Flexible(
              flex: 18,
              child: Container(),
            ),
            Flexible(
              flex: 7,
              child: Container(
                color: Colors.grey[100],
              ),
            ),
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            centerTitle: true,
            title: Text("HAMAGON"),
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        child: TextField(
                          controller: _name,
                          // onSubmitted: _searchName,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: Icon(Icons.search),
                              suffixIcon: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                child: RaisedButton(
                                    color: Color(0xff70a23a),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _searchName(context: context);
                                    }),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),
                              hintText: 'Cari nama hama disini...'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainImage()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset('assets/images/icons/hama-photo.png'),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailMain()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset('assets/images/icons/hama-search.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
