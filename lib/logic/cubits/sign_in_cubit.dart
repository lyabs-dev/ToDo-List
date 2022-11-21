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
    emit(state.copy());

    SignInCode? code;

        code = await _signInWithEmail();

    state.isLoading = false;

    if (code != null) {
      state.responseCode = SignInResponse(code: code, messageType: MessageType.toast) ;
    }

    emit(state.copy());
  }


  Future<SignInCode?> _signInWithEmail() async {

    if (state.emailEditingController.text.isEmpty || state.passwordEditingController.text.isEmpty) {
      return SignInCode.FillRequiredFields;
    }

    if (!RegExp(REG_EMAIL_VALID).hasMatch(state.emailEditingController.text)) {
      return SignInCode.InvalidEmail;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.emailEditingController.text,
        password: state.passwordEditingController.text,
      );

      if (userCredential.user == null) {
        return SignInCode.EmailPasswordIncorrect;
      }

      UserItem? user = await repository.getFromEmail(state.emailEditingController.text.toLowerCase());
      if (user == null) {
        return SignInCode.AuthFailed;
      }

      state.user = user;
    } on FirebaseAuthException catch (e) {
       if (e.code == 'email-already-in-use') {
        return SignInCode.EmailExists;
      } else if (e.code == 'invalid-email') {
        return SignInCode.InvalidEmail;
      }

      debugPrint('=====${e.code}=======Failed sign In Firebase: $e');
      return SignInCode.EmailPasswordIncorrect;
    } catch (e) {
      debugPrint('============Signin error: $e');
      return SignInCode.AuthFailed;
    }

    return null;

  }
}