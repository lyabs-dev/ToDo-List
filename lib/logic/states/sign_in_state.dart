import '../../data/models/response_code_item.dart';
import '../../data/models/user_item.dart';
import '../../utils/my_material.dart';

class SignInState {

  TextEditingController emailEditingController = TextEditingController(), passwordEditingController = TextEditingController();
  bool showPassword, isLoading;
  UserItem? user;
  SignInResponse? responseCode;

  SignInState({this.user, this.showPassword: false, this.isLoading: false, this.responseCode});

  SignInState copy() {
    SignInState copy = SignInState(user: user, showPassword: showPassword, isLoading: isLoading,
        responseCode: responseCode);

    copy.emailEditingController = emailEditingController;
    copy.passwordEditingController = passwordEditingController;

    return copy;
  }

}

enum SignInCode {
  AuthFailed,
  EmailExists,
  FillRequiredFields,
  InvalidEmail,
  EmailPasswordIncorrect,
  Connected;

}

class SignInResponse extends ResponseCodeItem {

  @override
  MessageType messageType;

  SignInCode code;

  SignInResponse({required this.code, this.messageType: MessageType.toast});

  @override
  String message(BuildContext context) {
    switch (code) {
      case SignInCode.FillRequiredFields:
        return AppLocalizations.of(context)!.fieldRequired;
      case SignInCode.EmailExists:
        return AppLocalizations.of(context)!.emailExists;
      case SignInCode.InvalidEmail:
        return AppLocalizations.of(context)!.invalidEmail;
      case SignInCode.EmailPasswordIncorrect:
        return AppLocalizations.of(context)!.emailPasswordIncorrect;
      case SignInCode.Connected:
        return AppLocalizations.of(context)!.signedSucces;
      case SignInCode.AuthFailed:
        return AppLocalizations.of(context)!.authFailed;
    }
  }

  @override
  DialogType get type {
    switch(code) {
      case SignInCode.AuthFailed:
      case SignInCode.InvalidEmail:
      case SignInCode.EmailExists:
      case SignInCode.EmailPasswordIncorrect:
        return DialogType.error;
      case SignInCode.FillRequiredFields:
      case SignInCode.InvalidEmail:
        return DialogType.warning;
      case SignInCode.Connected:
        return DialogType.success;
    }
  }
  
}