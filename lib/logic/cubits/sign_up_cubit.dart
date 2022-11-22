import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_item.dart';
import '../../data/repositories/user_repository.dart';
import '../../utils/my_material.dart';
import '../states/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {

  UserRepository repository = UserRepository();

  SignUpCubit(SignUpState initialState) : super(initialState);

  togglePasswordVisibility() {
    state.showPassword = !state.showPassword;
    emit(state.copy());
  }

  signUp() async {
    state.isLoading = true;
    emit(state.copy());

    SignUpCode? code = await _proccessSignUp();

    state.isLoading = false;

    if (code != null) {
      state.responseCode = SignUpResponse(code: code, messageType: MessageType.dialog);
    }

    emit(state.copy());
  }

  Future<SignUpCode?> _proccessSignUp() async {
    if (state.emailEditingController.text.isEmpty || state.passwordEditingController.text.isEmpty ||
        state.usernameEditingController.text.isEmpty) {
      return SignUpCode.FillRequiredFields;
    }

    if (!RegExp(REG_EMAIL_VALID).hasMatch(state.emailEditingController.text)) {
      return SignUpCode.InvalidEmail;
    }

    if (state.usernameEditingController.text.length < 2) {
      return SignUpCode.UsernameLeastCharacters;
    }

    //check if username is available
    bool? isExist = await repository.isUserExist(state.usernameEditingController.text);
    if (isExist == null || isExist) {
      return SignUpCode.UsernameExist;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.emailEditingController.text,
        password: state.passwordEditingController.text,
      );

      if (userCredential.user == null) {
        return SignUpCode.Error;
      }

      UserItem user = UserItem(
        email: state.emailEditingController.text, name: state.usernameEditingController.text.toLowerCase(),
        authId: userCredential.user!.uid,);
      // user.createdDate = DateTime.now();

      DocumentSnapshot? document = await repository.add(user);
      if (document == null) {
        return SignUpCode.Error;
      }
      user.document = document;
      user.authId = document.id;

      state.user = user;
      return SignUpCode.Connected;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return SignUpCode.PasswordWeak;
      } else if (e.code == 'email-already-in-use') {
        return SignUpCode.EmailExists;
      } else if (e.code == 'invalid-email') {
        return SignUpCode.InvalidEmail;
      }

      debugPrint('=====${e.code}=======Failed sign Up Firebase: $e');
      return SignUpCode.Error;
    } catch (e) {
      debugPrint('============Signup error: $e');
      return SignUpCode.Error;
    }
    return null;
  }
}




