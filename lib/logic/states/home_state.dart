import '../../data/models/note_item.dart';
import '../../data/models/response_code_item.dart';
import '../../utils/my_material.dart';

class HomeState {
  List<NoteItem?> notes;
  int noteNumber;
  NoteItem? currentNote;
  DateTime? sortingDate;
  HomeResponse? responseCode;
  bool loadingState;


  HomeState({this.loadingState= true,this.responseCode,this.sortingDate,this.noteNumber = 0 ,this.notes = const [], this.currentNote});

  HomeState copy() {
    HomeState copy = HomeState(
        loadingState: loadingState,
        responseCode: responseCode,
        currentNote: currentNote,
        sortingDate: sortingDate,
        noteNumber:noteNumber,
        notes:notes);

    return copy;
  }

}

enum HomeCode {
  Error,
  EmptyNote,
  Success
}

class HomeResponse extends ResponseCodeItem {

  @override
  MessageType messageType;

  HomeCode code;

  HomeResponse({required this.code, this.messageType: MessageType.toast});
  @override
  String message(BuildContext context) {
    switch (code) {
      case HomeCode.EmptyNote:
        return AppLocalizations.of(context)!.emptyNote;
      case HomeCode.Error:
        return AppLocalizations.of(context)!.error;
      case HomeCode.Success:
        return AppLocalizations.of(context)!.success;
    }
  }

  @override
  // TODO: implement type
  DialogType get type {
    switch(code) {
      case HomeCode.Error:
        return DialogType.error;
      case HomeCode.EmptyNote:
        return DialogType.info;
      case HomeCode.Success:
        return DialogType.success;
    }
  }

}