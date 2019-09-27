class PestRepo {
  List<Pest> pests = [
    Pest(),
    Pest(),
    Pest(),
    Pest(),
  ];

  List<Pest> searchName() {
    return pests;
  }

  List<Pest> searchDesc() {
    return pests;
  }
}

class Pest {
  String imageUrl = "https://4.bp.blogspot.com/-h90scNfOyuQ/V9q63wK9O2I/AAAAAAAACLQ/wPKBybq_zoYK9p9Qy0HXCY_Z88JC9wTnQCLcB/s1600/Mumen%2BRider.jpg";
  String name = "Kumbang elite";
  String description = "The elite bettle who strive to be the best bettle ever be on this farm";
  String recommendation = "Just shoo it. Attack its personality";
}