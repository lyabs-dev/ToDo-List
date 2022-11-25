import 'package:cloud_firestore/cloud_firestore.dart';


const COLLECTION_NOTE = 'notes';
const FIELD_USER_ID = 'user_id';
const FIELD_NOTE_TITLE = 'title';
const FIELD_NOTE_DESCRIPTION = 'description';
const FIELD_NOTE_DATETIME = 'datetime';
const FIELD_NOTE_REMIND = 'remind';
const FIELD_NOTE_CREATION_DATE = 'creation_date';
const FIELD_NOTE_DOCUMENT = 'document';


class NoteItem {
  String userId;
  String title;
  String description;
  DateTime dateTime;
  DateTime creationDate;
  bool remind;
  DocumentSnapshot? document;

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
    print('************PRINT MAP************');
    print(map);

    if(
        map[FIELD_USER_ID] != null &&
        map[FIELD_NOTE_TITLE] != null &&
        map[FIELD_NOTE_DESCRIPTION] !=null) {

      note = NoteItem(
          userId: map[FIELD_USER_ID],
          title: map[FIELD_NOTE_TITLE],
          description: map[FIELD_NOTE_DESCRIPTION],
          dateTime: map[FIELD_NOTE_DATETIME].toDate(),
          creationDate: map[FIELD_NOTE_CREATION_DATE].toDate(),
          remind: map[FIELD_NOTE_REMIND],
          document: map[FIELD_NOTE_DOCUMENT]
      );
      print('************JOKAL*****************');
      print(note.toString());
    }
    return note;
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

  @override
  String toString() {

    return 'id: '
        '$userId title: '
        '$title description:'
        ' $description datetime: '
        '$dateTime creation: '
        '$creationDate document: ${document.toString()}';
  }

}