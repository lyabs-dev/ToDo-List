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

    await _gettingNotes();

  }

  showMessage(HomeCode code , {messageType: MessageType.toast}) async {
    await Future.delayed(Duration(milliseconds: 200));
    state.loadingState = false;
    state.responseCode = HomeResponse(
      code: code,
      messageType: messageType,
    );
    emit(state.copy());
  }

  Future<HomeCode?> _gettingNotes() async {

    try{
      List<NoteItem?> notes = await noteRepository.getNotes();
      if(notes.isEmpty)  {
        showMessage(HomeCode.EmptyNote,messageType: MessageType.toast);
        return HomeCode.EmptyNote;
      }

      state.notes = notes;
      state.noteNumber = state.notes.length;
      showMessage(HomeCode.Success,messageType: MessageType.toast);
      return HomeCode.Success;

    } on FirebaseException catch (e) {
      showMessage(HomeCode.Error,messageType: MessageType.toast);
      return HomeCode.Error;
    }
  }

  deleteNote() {
    showMessage(HomeCode.WantDeleted,messageType: MessageType.dialog);
    print("******### I change THE MESSAGE ####*******");
  }

  _processDeleteNote(NoteItem note) async {
    try{
      bool isDelete = await noteRepository.delete(note);
      state.loadingState = true;
      emit(state.copy());


      if(isDelete){
        state.loadingState = false;
        showMessage(HomeCode.Deleted);
        emit(state.copy());
      }

    }on FirebaseException catch (e) {
      showMessage(HomeCode.Error);
      emit(state.copy());
    }
  }

}