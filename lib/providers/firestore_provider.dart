import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

// ── Caregiver Providers ───────────────────────────────────────────────────────

final caregiversProvider = StreamProvider.family<List<CaregiverModel>, String>((ref, agencyId) {
  return ref.watch(firestoreServiceProvider).caregiversStream(agencyId);
});

class CaregiverNotifier extends StateNotifier<AsyncValue<void>> {
  final FirestoreService _service;

  CaregiverNotifier(this._service) : super(const AsyncData(null));

  Future<void> create(CaregiverModel c) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.createCaregiver(c));
  }

  Future<void> update(CaregiverModel c) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.updateCaregiver(c));
  }

  Future<void> delete(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.deleteCaregiver(id));
  }
}

final caregiverNotifierProvider = StateNotifierProvider<CaregiverNotifier, AsyncValue<void>>((ref) {
  return CaregiverNotifier(ref.watch(firestoreServiceProvider));
});

// ── Patient Providers ─────────────────────────────────────────────────────────

final patientsProvider = StreamProvider.family<List<PatientModel>, String>((ref, agencyId) {
  return ref.watch(firestoreServiceProvider).patientsStream(agencyId);
});

class PatientNotifier extends StateNotifier<AsyncValue<void>> {
  final FirestoreService _service;

  PatientNotifier(this._service) : super(const AsyncData(null));

  Future<void> create(PatientModel p) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.createPatient(p));
  }

  Future<void> update(PatientModel p) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.updatePatient(p));
  }
}

final patientNotifierProvider = StateNotifierProvider<PatientNotifier, AsyncValue<void>>((ref) {
  return PatientNotifier(ref.watch(firestoreServiceProvider));
});

// ── Booking Providers ─────────────────────────────────────────────────────────

final bookingsProvider = StreamProvider.family<List<BookingModel>, String>((ref, agencyId) {
  return ref.watch(firestoreServiceProvider).bookingsStream(agencyId);
});

class BookingNotifier extends StateNotifier<AsyncValue<void>> {
  final FirestoreService _service;

  BookingNotifier(this._service) : super(const AsyncData(null));

  Future<void> create(BookingModel b) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.createBooking(b));
  }

  Future<void> updateStatus(String id, BookingStatus status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.updateBookingStatus(id, status));
  }
}

final bookingNotifierProvider = StateNotifierProvider<BookingNotifier, AsyncValue<void>>((ref) {
  return BookingNotifier(ref.watch(firestoreServiceProvider));
});

// ── Care Plan Providers ───────────────────────────────────────────────────────

final carePlansProvider = StreamProvider.family<List<CarePlanModel>, String>((ref, agencyId) {
  return ref.watch(firestoreServiceProvider).carePlansStream(agencyId);
});

// ── Dashboard Stats ───────────────────────────────────────────────────────────

final dashboardStatsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, agencyId) {
  return ref.watch(firestoreServiceProvider).getDashboardStats(agencyId);
});

// ── Notification Providers ────────────────────────────────────────────────────

final notificationsProvider = StreamProvider.family<List<NotificationModel>, String>((ref, userId) {
  return ref.watch(firestoreServiceProvider).notificationsStream(userId);
});

final unreadNotificationCountProvider = Provider.family<int, String>((ref, userId) {
  final notifs = ref.watch(notificationsProvider(userId));
  return notifs.when(
    data: (list) => list.where((n) => !n.isRead).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});
