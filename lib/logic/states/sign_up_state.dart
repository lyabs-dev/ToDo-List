

import '../../data/models/response_code_item.dart';
import '../../data/models/user_item.dart';
import '../../utils/my_material.dart';

class SignUpState {

  TextEditingController emailEditingController = TextEditingController(), passwordEditingController = TextEditingController(),
      usernameEditingController = TextEditingController();
  bool showPassword, isLoading;
  UserItem? user;
  SignUpResponse? responseCode;

  SignUpState({this.user, this.showPassword: false, this.isLoading: false, this.responseCode});

  SignUpState copy() {
    SignUpState copy = SignUpState(user: user, showPassword: showPassword, isLoading: isLoading,
        responseCode: responseCode);

    copy.emailEditingController = emailEditingController;
    copy.passwordEditingController = passwordEditingController;
    copy.usernameEditingController = usernameEditingController;

    return copy;
  }

}

enum SignUpCode {
  Error,
  UsernameExist,
  UsernameLeastCharacters,
  EmailExists,
  FillRequiredFields,
  InvalidEmail,
  Connected,
  PasswordWeak;
}

class SignUpResponse extends ResponseCodeItem {

  @override
  MessageType messageType;

  SignUpCode code;

  SignUpResponse({required this.code, this.messageType: MessageType.toast});

  @override
  String message(BuildContext context) {
    switch (code) {
      case SignUpCode.FillRequiredFields:
        return AppLocalizations.of(context)!.fieldRequired;
      case SignUpCode.EmailExists:
        return AppLocalizations.of(context)!.emailExists;
      case SignUpCode.InvalidEmail:
        return AppLocalizations.of(context)!.invalidEmail;
      case SignUpCode.Connected:
        return AppLocalizations.of(context)!.signedSucces;
      case SignUpCode.Error:
        return AppLocalizations.of(context)!.error;
      case SignUpCode.UsernameExist:
        return AppLocalizations.of(context)!.userExists;
      case SignUpCode.UsernameLeastCharacters:
        return AppLocalizations.of(context)!.usernameLeastCharacters;
      case SignUpCode.PasswordWeak:
        return AppLocalizations.of(context)!.passwordWeak;
    }
  }

  @override
  DialogType get type {
    switch(code) {
      case SignUpCode.PasswordWeak:
      case SignUpCode.Error:
      case SignUpCode.InvalidEmail:
      case SignUpCode.EmailExists:
        return DialogType.error;
      case SignUpCode.UsernameLeastCharacters:
      case SignUpCode.FillRequiredFields:
      case SignUpCode.InvalidEmail:
      case SignUpCode.UsernameExist:
        return DialogType.warning;
      case SignUpCode.Connected:
        return DialogType.success;
    }
  }

}