import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static void deleteDocument(reference) async {
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      myTransaction.delete(reference);
    });
  }
}
