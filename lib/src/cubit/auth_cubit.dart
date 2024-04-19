import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cubit/src/cubit/auth_states.dart';
import 'package:prueba_cubit/src/data_aource/firebase_data_source.dart';
import 'package:prueba_cubit/src/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDataSource _dataSource = FirebaseDataSource();

  AuthCubit() : super(AuthInitianState());

  String? verificationID;

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());

    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        verificationID = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationID = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(AuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await saveUserData(userCredential.user!);
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  Future<void> saveUserData(User user) async {
    UserModel myUser = UserModel(
      id: user.uid,
      isverified: 1,
      phone: user.phoneNumber,
    );
    await _dataSource.saveMyUser(myUser);
  }

  void logOut() async {
    emit(AuthLoggedOutState());
    _firebaseAuth.signOut();
  }
}
