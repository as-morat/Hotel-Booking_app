class Category {
  String image;
  String name;
  String price;
  String location;
  bool hdtv;
  bool wifi;
  bool kitchen;
  bool bathroom;
  String details;
  String id;

  Category({
    required this.image,
    required this.name,
    required this.price,
    required this.location,
    required this.hdtv,
    required this.wifi,
    required this.kitchen,
    required this.bathroom,
    required this.details,
    required this.id,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      location: map['location'] ?? '',
      hdtv: map['hdtv'] ?? false,
      wifi: map['wifi'] ?? false,
      kitchen: map['kitchen'] ?? false,
      bathroom: map['bathroom'] ?? false,
      details: map['details'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
