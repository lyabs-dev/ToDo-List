import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/data/models/note_item.dart';
import 'package:flutter_structure/logic/states/home_state.dart';

import '../../data/repositories/note_repository.dart';
import '../../utils/enums.dart';

class HomeCubit extends Cubit<HomeState>{

  NoteRepository noteRepository = NoteRepository();

  HomeCubit(HomeState initialState): super(initialState){
    intiData();
  }


  intiData() async {
    state.loadingState = true;
    emit(state.copy());


    HomeCode? code = await _gettingNotes();
    state.loadingState = false;
    
    print("**************####THE CODE $code");

    if(code != null) {
      state.responseCode = HomeResponse(code: code, messageType: MessageType.toast) ;
      
    }

    emit(state.copy());
  }

  Future<HomeCode?> _gettingNotes() async {

    try{
      List<NoteItem?> notes = await noteRepository.getNotes();
      if(notes.isEmpty)  {
        return HomeCode.EmptyNote;
      }

      state.notes = notes;
      state.noteNumber = state.notes.length;
      return HomeCode.Success;

    } on FirebaseException catch (e) {
      return HomeCode.Error;
    }
  }

}