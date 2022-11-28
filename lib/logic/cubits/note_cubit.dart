import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/data/models/note_item.dart';
import 'package:flutter_structure/data/models/user_item.dart';
import 'package:flutter_structure/data/repositories/note_repository.dart';
import 'package:flutter_structure/data/repositories/user_repository.dart';
import 'package:flutter_structure/logic/states/note_state.dart';
import '../../utils/enums.dart';

class NoteCubit extends Cubit<NoteState> {

  NoteRepository noteRepository = NoteRepository();
  UserRepository userRepository = UserRepository();

  NoteCubit(NoteState initaleState) : super(initaleState);



  createNote() async {

    print("************THIS MESTHOD**************");
    state.isLoading = true;
    emit(state.copy());

    NoteCode? code = await _processCreateNote();
    print("**********${code}*************");


    state.isLoading = false;

    if (code != null) {
      state.responseCode = NoteResponse(code: code, messageType: MessageType.toast) ;
    }

    emit(state.copy());
  }


  Future<NoteCode?> _processCreateNote() async {
    if (state.titleEditingController.text.isEmpty || state.descriptionEditingController.text.isEmpty) {
      showMessage(NoteCode.FillRequiredFields);
      return NoteCode.FillRequiredFields;
    }

    print("**********IS NOT EMPTY*************");

    //check if title is available
    bool? isExist = await noteRepository.isTitleExist(state.titleEditingController.text);
    if (isExist == null || isExist) {
      showMessage(NoteCode.TitleExist);
      return NoteCode.TitleExist;
    }

    UserItem? currentUser = await userRepository.getCurrentUser();

    NoteItem? note = NoteItem(userId:currentUser!.authId,
        title: state.titleEditingController.text,
        description: state.descriptionEditingController.text,
        dateTime: DateTime.now(), creationDate: DateTime.now(), remind: state.remind
    );

    print("########## THE NOTE################");
    print(note);
    DocumentSnapshot? doc = await noteRepository.add(note);
    if(doc == null){
      showMessage(NoteCode.Error);
      return NoteCode.Error;
    }

    state.note = note;
    showMessage(NoteCode.Created);
    return NoteCode.Created;
  }

  showMessage(NoteCode code , {messageType: MessageType.toast}) async {
    await Future.delayed(Duration(milliseconds: 200));
    state.isLoading = false;
    state.responseCode = NoteResponse(
      code: code,
      messageType: messageType,
    );
    emit(state.copy());
  }

}