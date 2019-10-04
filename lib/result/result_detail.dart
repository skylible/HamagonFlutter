import 'package:flutter/material.dart';
import 'package:hamagon/model/pest_repo.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ResultDetail extends StatelessWidget {
  final Pest pest;

  const ResultDetail({Key key, this.pest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _panelHeightOpen = 600.0;
    double _panelHeightClosed = 250.0;
    return Scaffold(
      backgroundColor: Color(0xff628336),
      appBar: AppBar(
        title: Text("Detail Hama"),
        elevation: 0,
        backgroundColor: Color(0xff628336),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          ),
        ),
      ),
      body: SlidingUpPanel(
        maxHeight: _panelHeightOpen,
        minHeight: _panelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: .5,
        body: _body(),
        panel: _panel(),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      ),
    );
  }

  Widget _panel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        SizedBox(
          height: 18.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              pest.name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // _button("Popular", Icons.favorite, Colors.blue),
            // _button("Food", Icons.restaurant, Colors.red),
            // _button("Events", Icons.event, Colors.amber),
            //_button("More", Icons.more_horiz, Colors.green),
          ],
        ),
        SizedBox(
          height: 36.0,
        ),
        Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Deskripsi",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xff628336))),
              SizedBox(
                height: 12.0,
              ),
              Text(
                pest.description,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36.0,
        ),
        Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Tanaman Inang",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xff628336))),
              SizedBox(
                height: 12.0,
              ),
              Text(
                pest.hostTree,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36.0,
        ),
        Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Cara Penanganan",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xff628336))),
              SizedBox(
                height: 12.0,
              ),
              Text(
                pest.recommendation,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Container(
        margin: const EdgeInsets.only(bottom: 300),
        child: CarouselSlider(
            height: 300.0,
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.network(pest.imageUrl));
                },
              );
            }).toList()));
  }
}
