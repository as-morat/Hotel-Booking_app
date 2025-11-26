import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/booking_dao.dart';
import '../data/booking_repository.dart';
import '../model/booking_model.dart';

final bookingDaoProvider = Provider<BookingDao>((ref) {
  return BookingDao();
});

final bookingControllerProvider =
    NotifierProvider<BookingController, BookingState>(() {
      return BookingController();
    });

class BookingState {
  final List<BookingModel> bookings;
  final bool loading;

  BookingState({this.bookings = const [], this.loading = false});

  BookingState copyWith({List<BookingModel>? bookings, bool? loading}) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      loading: loading ?? this.loading,
    );
  }
}

class BookingController extends Notifier<BookingState> {
  late BookingRepository repo;

  @override
  BookingState build() {
    repo = BookingRepository(ref.watch(bookingDaoProvider));
    return BookingState();
  }

  Future<void> loadBookings(String userId) async {
    state = state.copyWith(loading: true);
    final data = await repo.getBookings(userId);
    state = state.copyWith(bookings: data, loading: false);
  }

  Future<void> addBooking(BookingModel booking) async {
    await repo.saveBooking(booking);
    await loadBookings(booking.userId);
  }

  Future<void> confirm(String id, String userId) async {
    await repo.confirmBooking(id);
    await loadBookings(userId);
  }


  Future<void> delete(String id, String userId) async {
    await repo.deleteBooking(id);
    await loadBookings(userId);
  }
}
