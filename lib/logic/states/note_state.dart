import 'package:flutter_structure/data/models/note_item.dart';

import '../../data/models/response_code_item.dart';
import '../../utils/my_material.dart';

class NoteState{
  TextEditingController titleEditingController = TextEditingController(),descriptionEditingController = TextEditingController();
  DateTime? dateTime = DateTime.now() ;
  String? userId;
  NoteItem? note;
  bool remind = false,isLoading;
  NoteResponse? responseCode;

  NoteState({this.responseCode,this.note,this.userId,this.dateTime,this.isLoading:false});

  NoteState copy() {
    NoteState copy = NoteState(responseCode: responseCode,note:note,userId:userId, dateTime: dateTime,isLoading: isLoading);

    copy.titleEditingController = titleEditingController;
    copy.descriptionEditingController = descriptionEditingController;
    return copy;
  }

}

enum NoteCode {
  Error,
  TitleExist,
  FillRequiredFields,
  Created
}

class NoteResponse extends ResponseCodeItem {

  @override
  MessageType messageType;

  NoteCode code;

  NoteResponse({required this.code, this.messageType: MessageType.toast});
  @override
  String message(BuildContext context) {
    switch (code) {
      case NoteCode.FillRequiredFields:
        return AppLocalizations.of(context)!.fieldRequired;
      case NoteCode.Error:
        return AppLocalizations.of(context)!.error;
      case NoteCode.TitleExist:
        return AppLocalizations.of(context)!.titleExist;
      case NoteCode.Created:
        return AppLocalizations.of(context)!.created;
    }
  }

  @override
  // TODO: implement type
  DialogType get type {
    switch(code) {
      case NoteCode.Error:
        return DialogType.error;
      case NoteCode.TitleExist:
      case NoteCode.FillRequiredFields:
        return DialogType.warning;
      case NoteCode.Created:
        return DialogType.success;

    }
  }

}