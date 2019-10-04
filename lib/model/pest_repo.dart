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

    for (var pest in pests) {
      if (pest.hostTree.toLowerCase().contains(hostTree.toLowerCase()) &&
          pest.description.toLowerCase().contains(keyword.toLowerCase())) {
        results.add(pest);
      }
    }
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

  Pest(this.imageUrl, this.name, this.description, this.recommendation,
      this.hostTree, {this.confidence});
}
