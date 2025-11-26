class Booking {
  final String id;
  final String userId;
  final String title;
  final String price;
  final String location;
  final String image;
  final String guest;
  final String checkIn;
  final String checkOut;
  final bool isConfirmed;

  Booking({
    required this.id,
    required this.userId,
    required this.title,
    required this.price,
    required this.location,
    required this.image,
    required this.guest,
    required this.checkIn,
    required this.checkOut,
    required this.isConfirmed,
  });
}

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.price,
    required super.location,
    required super.image,
    required super.guest,
    required super.checkIn,
    required super.checkOut,
    required super.isConfirmed,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      price: map['price'],
      location: map['location'],
      image: map['image'],
      guest: map['guest'],
      checkIn: map['checkIn'],
      checkOut: map['checkOut'],
      isConfirmed: map['isConfirmed'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'price': price,
      'location': location,
      'image': image,
      'guest': guest,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'isConfirmed': isConfirmed ? 1 : 0,
    };
  }
}
