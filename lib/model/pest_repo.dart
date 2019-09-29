class PestRepo {
  List<Pest> pests = [
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
  final String name;
  final double description;
  final String recommendation = "Just shoo it. Attack its personality";

  Pest(this.name, this.description);
}