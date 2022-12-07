import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/logic/states/sign_in_state.dart';
import '../../data/models/user_item.dart';
import '../../data/repositories/user_repository.dart';
import '../../utils/my_material.dart';

class SignInCubit extends Cubit<SignInState> {

  SignInCubit(SignInState initialState) : super(initialState);
  UserRepository repository = UserRepository();

  togglePasswordVisibility() {
    state.showPassword = !state.showPassword;
    emit(state.copy());
  }

  signIn() async {
    state.isLoading = true;
    state.responseCode = null;
    emit(state.copy());

    await _signInWithEmail();

  }


  Future<SignInCode?> _signInWithEmail() async {

    if (state.emailEditingController.text.isEmpty || state.passwordEditingController.text.isEmpty) {
      showMessage(SignInCode.FillRequiredFields);
      return SignInCode.FillRequiredFields;
    }

    if (!RegExp(REG_EMAIL_VALID).hasMatch(state.emailEditingController.text)) {
      showMessage(SignInCode.InvalidEmail);
      return SignInCode.InvalidEmail;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.emailEditingController.text,
        password: state.passwordEditingController.text,
      );

      if (userCredential.user == null) {
        showMessage(SignInCode.EmailPasswordIncorrect);
        return SignInCode.EmailPasswordIncorrect;
      }

      UserItem? user = await repository.getFromEmail(state.emailEditingController.text.toLowerCase());
      if (user == null) {
        showMessage(SignInCode.AuthFailed);
        return SignInCode.AuthFailed;
      }

      state.user = user;
      showMessage(SignInCode.Connected);
      return SignInCode.Connected;

    } on FirebaseAuthException catch (e) {
       if (e.code == 'email-already-in-use') {
         showMessage(SignInCode.EmailExists);
         return SignInCode.EmailExists;
      } else if (e.code == 'invalid-email') {
         showMessage(SignInCode.InvalidEmail);
         return SignInCode.InvalidEmail;
      }

      debugPrint('=====${e.code}=======Failed sign In Firebase: $e');
       showMessage(SignInCode.EmailPasswordIncorrect,messageType: MessageType.dialog);
       return SignInCode.EmailPasswordIncorrect;
    } catch (e) {
      debugPrint('============Signin error: $e');
      return SignInCode.AuthFailed;
    }
  }

  showMessage(SignInCode code , {messageType: MessageType.toast}) async {
    await Future.delayed(Duration(milliseconds: 200));
    state.isLoading = false;
    state.responseCode = SignInResponse(
      code: code,
      messageType: messageType,
    );
    emit(state.copy());
  }
}