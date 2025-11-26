import '../data/booking_dao.dart';
import '../model/booking_model.dart';

class BookingRepository {
  final BookingDao dao;

  BookingRepository(this.dao);

  Future<void> saveBooking(BookingModel booking) => dao.insertBooking(booking);

  Future<void> confirmBooking(String id) => dao.confirmBooking(id);

  Future<List<BookingModel>> getBookings(String userId) =>
      dao.getBookings(userId);

  Future<void> deleteBooking(String id) => dao.deleteBooking(id);
}
