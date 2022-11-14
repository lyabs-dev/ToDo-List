import 'package:cloud_firestore/cloud_firestore.dart';


const FIELD_USER_ID = 'user_id';
const FIELD_NOTE_TITLE = 'title';
const FIELD_NOTE_DESCRIPTION = 'description';
const FIELD_NOTE_DATETIME = 'datetime';
const FIELD_NOTE_REMIND = 'remind';
const FIELD_NOTE_CREATION_DATE = 'creation_date';
const FIELD_NOTE_DOCUMENT = 'document';


class NoteItem {
  final String userId;
  final String title;
  final String description;
  final DateTime dateTime;
  final DateTime creationDate;
  final bool remind;
  final DocumentSnapshot? document;

  NoteItem({
    required this.userId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.creationDate,
    required this.remind,
    this.document
  });

  factory NoteItem.defaultNote()=>
      NoteItem(
        userId: '',
        title: '',
        description: '',
        dateTime: DateTime.now(),
        creationDate: DateTime.now(),
        remind: false
      );

  static NoteItem? fromMap(Map map) {
    NoteItem? note;

    if(
        map[FIELD_USER_ID] != null &&
        map[FIELD_NOTE_TITLE] != null &&
        map[FIELD_NOTE_DESCRIPTION] !=null &&
        map[FIELD_NOTE_CREATION_DATE] != null) {

      note = NoteItem(
          userId: map[FIELD_USER_ID],
          title: map[FIELD_NOTE_TITLE],
          description: map[FIELD_NOTE_DESCRIPTION],
          dateTime: map[FIELD_NOTE_DATETIME],
          creationDate: map[FIELD_NOTE_CREATION_DATE],
          remind: map[FIELD_NOTE_REMIND],
          document: map[FIELD_NOTE_DOCUMENT]
      );
    }
  }

  Map<String, Object> toMap(){
    return {
      FIELD_USER_ID: userId,
      FIELD_NOTE_TITLE: title,
      FIELD_NOTE_DESCRIPTION: description,
      FIELD_NOTE_CREATION_DATE: creationDate,
      FIELD_NOTE_DATETIME: dateTime,
      FIELD_NOTE_REMIND: remind
    };
  }

}