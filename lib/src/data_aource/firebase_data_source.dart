import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_cubit/src/models/user_model.dart';

class FirebaseDataSource {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  Future<void> saveMyUser(UserModel myUser) async {
    final ref = firestore.doc('user/${currentUser.uid}/myUsers/${myUser.id}');

    await ref.set(myUser.toFirebaseMap(), SetOptions(merge: true));
  }
}
