import 'package:cloud_firestore/cloud_firestore.dart';

class PestRepo {
  PestRepo() {
    print("Pest Repo constructed!");
    Firestore.instance.collection(collectionName).snapshots().listen(
          (data) => data.documents.forEach(
            (doc) {
              print(doc["name"]);
              pests.add(
                Pest(doc['image_url'], doc["name"], doc["description"],
                    doc["recommendation"], doc["host_tree"]),
              );
            },
          ),
        );
  }

  static String collectionName = "test_labels";
  List<Pest> pests = [];

  List<Pest> searchName({String name}) {
    List<Pest> results = [];

    for (var pest in pests) {
      if (pest.name.toLowerCase().contains(name.toLowerCase())) {
        results.add(pest);
      }
    }
    return results;
  }

  // NOT IDEAL IF DATA IS THOUSANDS, TEMPORARY SOLUTION
  List<Pest> searchDesc(String hostTree, String keyword) {
    List<Pest> results = [];
    List<String> hostTreeQuery = [];
    List<String> keywordQuery = [];

    if (hostTree != "") hostTreeQuery = hostTree.split(' ');
    if (keyword != "") keywordQuery = keyword.split(' ');

    for (var pest in pests) {
      pest.score = 0;
      if (hostTreeQuery.isNotEmpty) {
        for (String term in hostTreeQuery) {
          if (pest.hostTree.toLowerCase().contains(term.toLowerCase())) {
            if (!results.contains(pest)) {
              pest.score += 3;
              results.add(pest);
            } else {
              pest.score += 3;
            }
          }
        }
      }

      if (keywordQuery.isNotEmpty) {
        for (String term in keywordQuery) {
          if (pest.description.toLowerCase().contains(term.toLowerCase())) {
            if (!results.contains(pest)) {
              pest.score += 1;
              results.add(pest);
            } else {
              pest.score += 1;
            }
          }
        }
      }
    }

    results.sort((a, b) => a.score.compareTo(b.score));
    return results;
  }
}

class Pest {
  final String imageUrl;
  final String name;
  final String description;
  final String recommendation;
  final String hostTree;
  double confidence = 0;
  double score = 0;

  Pest(this.imageUrl, this.name, this.description, this.recommendation,
      this.hostTree,
      {this.confidence});
}
