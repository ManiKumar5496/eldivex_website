import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);
  @override
  String toString() => message;
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserModel> signInWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      return _getOrCreateUserModel(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AppException(_authErrorMessage(e.code));
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();
      provider.setCustomParameters({'prompt': 'select_account'});
      final credential = await _auth.signInWithPopup(provider);
      return _getOrCreateUserModel(credential.user!, fromGoogle: true);
    } on FirebaseAuthException catch (e) {
      throw AppException(_authErrorMessage(e.code));
    } catch (e) {
      throw AppException('Google sign-in failed. Please try again.');
    }
  }

  Future<UserModel> registerWithEmailPassword({
    required String email,
    required String displayName,
    required String password,
    required UserRole role,
    String? phoneNumber,
    String? agencyId,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      await credential.user!.updateDisplayName(displayName);
      final now = DateTime.now();
      final user = UserModel(
        id: credential.user!.uid,
        email: email.trim(),
        displayName: displayName,
        role: role,
        phoneNumber: phoneNumber,
        agencyId: agencyId,
        isEmailVerified: false,
        createdAt: now,
        updatedAt: now,
      );
      await _db.collection('users').doc(user.id).set(user.toFirestore());
      return user;
    } on FirebaseAuthException catch (e) {
      throw AppException(_authErrorMessage(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AppException(_authErrorMessage(e.code));
    }
  }

  Future<UserModel?> getCurrentUserModel() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final doc = await _db.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  Future<UserModel> _getOrCreateUserModel(User firebaseUser, {bool fromGoogle = false}) async {
    final doc = await _db.collection('users').doc(firebaseUser.uid).get();
    if (doc.exists) return UserModel.fromFirestore(doc);

    final now = DateTime.now();
    final user = UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? 'User',
      photoUrl: firebaseUser.photoURL,
      role: UserRole.admin,
      isEmailVerified: fromGoogle,
      createdAt: now,
      updatedAt: now,
    );
    await _db.collection('users').doc(user.id).set(user.toFirestore());
    return user;
  }

  String _authErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
