import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';
import 'package:hamagon/result/result_list.dart';

class DetailMain extends StatefulWidget {
  @override
  _DetailMainState createState() => _DetailMainState();
}

class _DetailMainState extends State<DetailMain> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inang = TextEditingController(text: "");
  TextEditingController _deskripsi = TextEditingController(text: "");
  var _loading = false;
  PestRepo pestRepo = PestRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pencarian Ciri-Ciri"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _inang,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(0),
                      ),
                    ),
                    suffixIcon: Icon(Icons.color_lens),
                    hintText: 'Tanaman yang menjadi target hama',
                    labelText: 'Tanaman Inang',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _deskripsi,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(0),
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard),
                    hintText: 'Misalnya merah, besar, keong, dsb',
                    labelText: 'Kata kunci',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      // Scaffold.of(context).showSnackBar(
                      //     SnackBar(content: Text('Processing Data')));
                      _search();
                    }
                  },
                  child: Text(
                    'Cari',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _search() {
    setState(() {
      _loading = true;
    });

    var results = pestRepo.searchDesc(this._inang.text, this._deskripsi.text);

    setState(() {
      _loading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultList(
          results: results,
        ),
      ),
    );
  }
}
