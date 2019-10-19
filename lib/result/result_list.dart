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
        backgroundColor: Color(0xff70a23a),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: results.length != 0
          ? ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultDetail(
                                    pest: results[index],
                                  )));
                    },
                    child: results[index].confidence != null
                        ? ListTile(
                            leading: Image.network(
                              results[index].imageUrl,
                              width: 56,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                );
                              },
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                            title: Text(results[index].name),
                            subtitle: Text((results[index].confidence * 100)
                                    .toString()
                                    .substring(0, 5) +
                                '%'),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff628336),
                              size: 16,
                            ),
                          )
                        : ListTile(
                            leading: Image.network(
                              results[index].imageUrl,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                            title: Text(results[index].name),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff628336),
                              size: 16,
                            ),
                          ),
                  ),
                );
              },
            )
          : Container(
            padding: EdgeInsets.all(12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icons/hama-confused.png',
                      height: 152,
                    ),
                    Text(
                      "Wah, hama tidak ditemukan.",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Silahkan coba lagi dengan foto yang lain. Pastikan hama terlihat jelas di foto",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
