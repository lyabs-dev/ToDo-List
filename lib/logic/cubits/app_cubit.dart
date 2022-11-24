import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/data/tests/app_test.dart';
import 'package:flutter_structure/logic/states/app_state.dart';
import 'package:flutter_structure/utils/enums.dart';

import '../../data/models/user_item.dart';
import '../../data/repositories/user_repository.dart';

class AppCubit extends Cubit<AppState> {

  UserRepository userRepository = UserRepository();

  AppCubit(AppState initialState) : super(initialState) {
    intiData();
  }

  intiData() async {
    AppTest.run();
    state.loadingState = CustomState.loading;
    emit(state.copy());

    state.user = await userRepository.getCurrentUser();
    //emit(state.copy());

    print('************PRINT USER#################');
    print(state.user);

    state.loadingState = CustomState.done;
    emit(state.copy());
  }

  Future setUser(UserItem user) async {
    state.user = user;
    await userRepository.setCurrentUser(user);
    emit(state.copy());
  }


}