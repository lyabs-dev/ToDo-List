import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/logic/states/home_state.dart';

import '../../data/repositories/note_repository.dart';

class HomeCubit extends Cubit{

  NoteRepository noteRepository = NoteRepository();

  HomeCubit(HomeState initialState): super(initialState);

}