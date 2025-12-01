import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicehub/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';
import 'package:servicehub/model/user_model.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred;
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code);
    }
  }

  Future<UserCredential> signupWithEmailPassword({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = cred.user!.uid;
      final now = DateTime.now();
      final firestore = FirebaseFirestore.instance;
      final addressId = firestore.collection('users').doc(uid).collection('addresses').doc().id;
      await firestore.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'role': role == 'service_provider' ? 'provider' : 'user',
        'createdAt': now,
        'profileImageUrl': '',
        'favorites': <String>[],
        'city': '',
        'address': [
          {
            'addressId': addressId,
            'label': 'Home',
            'address': '',
            'lat': null,
            'lng': null,
          }
        ],
        'walletId': 'wallet_$uid',
        'isSubscriptionPaid': false,
      });
      if (role == 'service_provider') {
        await firestore.collection('providers').doc(uid).set({
          'userRef': firestore.collection('users').doc(uid).path,
          'displayName': fullName,
          'verified': false,
          'status': 'pending',
          'createdAt': now,
        });
      }
      final userModel = UserModel(
        id: uid,
        fullName: fullName,
        email: email,
        role: role == 'service_provider' ? 'provider' : 'user',
        profileImageUrl: '',
        createdAt: now,
        favorites: const [],
        city: '',
        address: [AddressModel(addressId: addressId, label: 'Home', address: '')],
        walletId: 'wallet_$uid',
        isSubscriptionPaid: false, deviceTokens: [],
      );
      await MyLocalStorage.instance().writeData('user', userModel.toJson());
      return cred;
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code);
    }
  }
}
