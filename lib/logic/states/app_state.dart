import 'package:flutter_structure/utils/enums.dart';

import '../../data/models/user_item.dart';

class AppState {

  CustomState loadingState;
  UserItem? user;

  AppState({this.user,this.loadingState = CustomState.loading,});


  AppState copy() {
    AppState copy = AppState(loadingState: loadingState,user:user );

    return copy;
  }

}