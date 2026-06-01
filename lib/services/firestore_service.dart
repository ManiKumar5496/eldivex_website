import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Generic ──────────────────────────────────────────────────────────────

  Future<void> setDocument(String col, String id, Map<String, dynamic> data) =>
      _db.collection(col).doc(id).set(data, SetOptions(merge: true));

  Future<void> updateDocument(String col, String id, Map<String, dynamic> data) =>
      _db.collection(col).doc(id).update(data);

  Future<void> deleteDocument(String col, String id) => _db.collection(col).doc(id).delete();

  Future<DocumentSnapshot> getDocument(String col, String id) => _db.collection(col).doc(id).get();

  // ── Users ─────────────────────────────────────────────────────────────────

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  Future<void> updateUser(UserModel user) =>
      _db.collection('users').doc(user.id).set(user.toFirestore()..['updatedAt'] = FieldValue.serverTimestamp(), SetOptions(merge: true));

  // ── Caregivers ────────────────────────────────────────────────────────────

  Stream<List<CaregiverModel>> caregiversStream(String agencyId) => _db
      .collection('caregivers')
      .where('agencyId', isEqualTo: agencyId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(CaregiverModel.fromFirestore).toList());

  Future<CaregiverModel?> getCaregiver(String id) async {
    final doc = await _db.collection('caregivers').doc(id).get();
    if (!doc.exists) return null;
    return CaregiverModel.fromFirestore(doc);
  }

  Future<void> createCaregiver(CaregiverModel c) =>
      _db.collection('caregivers').doc(c.id).set(c.toFirestore());

  Future<void> updateCaregiver(CaregiverModel c) =>
      _db.collection('caregivers').doc(c.id).update({...c.toFirestore(), 'updatedAt': FieldValue.serverTimestamp()});

  Future<void> deleteCaregiver(String id) => _db.collection('caregivers').doc(id).delete();

  // ── Patients ──────────────────────────────────────────────────────────────

  Stream<List<PatientModel>> patientsStream(String agencyId) => _db
      .collection('patients')
      .where('agencyId', isEqualTo: agencyId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(PatientModel.fromFirestore).toList());

  Future<PatientModel?> getPatient(String id) async {
    final doc = await _db.collection('patients').doc(id).get();
    if (!doc.exists) return null;
    return PatientModel.fromFirestore(doc);
  }

  Future<void> createPatient(PatientModel p) =>
      _db.collection('patients').doc(p.id).set(p.toFirestore());

  Future<void> updatePatient(PatientModel p) =>
      _db.collection('patients').doc(p.id).update({...p.toFirestore(), 'updatedAt': FieldValue.serverTimestamp()});

  // ── Bookings ──────────────────────────────────────────────────────────────

  Stream<List<BookingModel>> bookingsStream(String agencyId, {DateTime? startDate, DateTime? endDate}) {
    var query = _db.collection('bookings').where('agencyId', isEqualTo: agencyId);
    if (startDate != null) query = query.where('startTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
    if (endDate != null) query = query.where('startTime', isLessThanOrEqualTo: Timestamp.fromDate(endDate));
    return query.orderBy('startTime', descending: true).snapshots().map((s) => s.docs.map(BookingModel.fromFirestore).toList());
  }

  Future<BookingModel?> getBooking(String id) async {
    final doc = await _db.collection('bookings').doc(id).get();
    if (!doc.exists) return null;
    return BookingModel.fromFirestore(doc);
  }

  Future<void> createBooking(BookingModel b) =>
      _db.collection('bookings').doc(b.id).set(b.toFirestore());

  Future<void> updateBookingStatus(String id, BookingStatus status) =>
      _db.collection('bookings').doc(id).update({'status': status.name, 'updatedAt': FieldValue.serverTimestamp()});

  Future<void> updateBooking(BookingModel b) =>
      _db.collection('bookings').doc(b.id).update({...b.toFirestore(), 'updatedAt': FieldValue.serverTimestamp()});

  // ── Care Plans ────────────────────────────────────────────────────────────

  Stream<List<CarePlanModel>> carePlansStream(String agencyId, {String? patientId}) {
    var query = _db.collection('careplans').where('agencyId', isEqualTo: agencyId);
    if (patientId != null) query = query.where('patientId', isEqualTo: patientId);
    return query.orderBy('createdAt', descending: true).snapshots().map((s) => s.docs.map(CarePlanModel.fromFirestore).toList());
  }

  Future<void> createCarePlan(CarePlanModel cp) =>
      _db.collection('careplans').doc(cp.id).set(cp.toFirestore());

  Future<void> updateCarePlan(CarePlanModel cp) =>
      _db.collection('careplans').doc(cp.id).update({...cp.toFirestore(), 'updatedAt': FieldValue.serverTimestamp()});

  // ── Notifications ─────────────────────────────────────────────────────────

  Stream<List<NotificationModel>> notificationsStream(String userId, {int limit = 20}) => _db
      .collection('notifications')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .map((s) => s.docs.map(NotificationModel.fromFirestore).toList());

  Future<void> markNotificationRead(String id) =>
      _db.collection('notifications').doc(id).update({'isRead': true});

  Future<void> markAllNotificationsRead(String userId) async {
    final batch = _db.batch();
    final snap = await _db.collection('notifications').where('userId', isEqualTo: userId).where('isRead', isEqualTo: false).get();
    for (final doc in snap.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // ── Dashboard Stats ───────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getDashboardStats(String agencyId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final results = await Future.wait([
      _db.collection('caregivers').where('agencyId', isEqualTo: agencyId).count().get(),
      _db.collection('patients').where('agencyId', isEqualTo: agencyId).where('status', isEqualTo: 'active').count().get(),
      _db.collection('bookings').where('agencyId', isEqualTo: agencyId).where('startTime', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart)).where('startTime', isLessThan: Timestamp.fromDate(todayEnd)).count().get(),
      _db.collection('bookings').where('agencyId', isEqualTo: agencyId).where('status', isEqualTo: 'completed').count().get(),
    ]);

    return {
      'totalCaregivers': results[0].count ?? 0,
      'activePatients': results[1].count ?? 0,
      'todayBookings': results[2].count ?? 0,
      'completedBookings': results[3].count ?? 0,
      'monthlyRevenue': 0.0,
    };
  }
}
