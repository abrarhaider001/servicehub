import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletService {
  final _fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<double> getBalance() async {
    final uid = _uid;
    if (uid == null) return 0.0;
    final snap = await _fs.collection('wallets').doc(uid).get();
    return (snap.data()?['balance'] as num?)?.toDouble() ?? 0.0;
  }

  Stream<double> streamBalance() {
    final uid = _uid;
    if (uid == null) return const Stream<double>.empty();
    return _fs.collection('wallets').doc(uid).snapshots().map((s) => (s.data()?['balance'] as num?)?.toDouble() ?? 0.0);
  }

  Future<void> deposit({required double amount, String method = 'card', String? cardLast4}) async {
    final uid = _uid;
    if (uid == null) throw Exception('Not authenticated');
    if (amount <= 0) throw Exception('Invalid amount');

    await _fs.collection('wallets').doc(uid).set({
      'balance': FieldValue.increment(amount),
      'currency': 'USD',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final desc = cardLast4 == null ? 'Deposited via $method' : 'Deposited via card ****$cardLast4';
    await _fs.collection('users').doc(uid).collection('transactionHistory').add({
      'datetime': FieldValue.serverTimestamp(),
      'amount': amount,
      'type': 'deposit',
      'title': 'Wallet deposit',
      'description': desc,
    });
  }

  Future<void> withdraw({required double amount, String method = 'card'}) async {
    final uid = _uid;
    if (uid == null) throw Exception('Not authenticated');
    if (amount <= 0) throw Exception('Invalid amount');

    final walletRef = _fs.collection('wallets').doc(uid);
    final snap = await walletRef.get();
    final balance = (snap.data()?['balance'] as num?)?.toDouble() ?? 0.0;
    if (amount > balance) throw Exception('Insufficient balance');

    await walletRef.set({
      'balance': FieldValue.increment(-amount),
      'currency': 'USD',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await _fs.collection('users').doc(uid).collection('transactionHistory').add({
      'datetime': FieldValue.serverTimestamp(),
      'amount': amount,
      'type': 'withdraw',
      'title': 'Wallet withdraw',
      'description': 'Withdraw via $method',
    });
  }
}

