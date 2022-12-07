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
    state.responseCode = null;
    emit(state.copy());

    await _proccessSignUp();

  }

  Future<SignUpCode?> _proccessSignUp() async {
    if (state.emailEditingController.text.isEmpty || state.passwordEditingController.text.isEmpty ||
        state.usernameEditingController.text.isEmpty) {
      showMessage(SignUpCode.FillRequiredFields);
      return SignUpCode.FillRequiredFields;
    }

    if (!RegExp(REG_EMAIL_VALID).hasMatch(state.emailEditingController.text)) {
      showMessage(SignUpCode.InvalidEmail);
      return SignUpCode.InvalidEmail;
    }

    if (state.usernameEditingController.text.length < 2) {
      showMessage(SignUpCode.UsernameLeastCharacters);
      return SignUpCode.UsernameLeastCharacters;
    }

    //check if username is available
    bool? isExist = await repository.isUserExist(state.usernameEditingController.text);
    if (isExist == null || isExist) {
      showMessage(SignUpCode.UsernameExist);
      return SignUpCode.UsernameExist;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.emailEditingController.text,
        password: state.passwordEditingController.text,
      );

      if (userCredential.user == null) {
        showMessage(SignUpCode.Error);
        return SignUpCode.Error;
      }

      UserItem user = UserItem(
        email: state.emailEditingController.text.toLowerCase(), name: state.usernameEditingController.text.toLowerCase(),
        authId: userCredential.user!.uid);

      DocumentSnapshot? document = await repository.add(user);
      if (document == null) {
        return SignUpCode.Error;
      }
      user.document = document;
      user.authId = document.id;

      state.user = user;
      showMessage(SignUpCode.Connected);
      return SignUpCode.Connected;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMessage(SignUpCode.PasswordWeak);
        return SignUpCode.PasswordWeak;
      } else if (e.code == 'email-already-in-use') {
        showMessage(SignUpCode.EmailExists);
        return SignUpCode.EmailExists;
      } else if (e.code == 'invalid-email') {
        showMessage(SignUpCode.InvalidEmail);
        return SignUpCode.InvalidEmail;
      }

      debugPrint('=====${e.code}=======Failed sign Up Firebase: $e');
      return SignUpCode.Error;
    } catch (e) {
      debugPrint('============Signup error: $e');
      return SignUpCode.Error;
    }
  }

  showMessage(SignUpCode code , {messageType: MessageType.toast}) async {
    await Future.delayed(Duration(milliseconds: 200));
    state.isLoading = false;
    state.responseCode = SignUpResponse(
      code: code,
      messageType: messageType,
    );
    emit(state.copy());
  }
}




