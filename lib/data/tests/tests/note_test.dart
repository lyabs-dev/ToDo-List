import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/tests/tests/user_test.dart';
import 'package:test/test.dart' as test;

import '../../models/note_item.dart';
import '../../repositories/note_repository.dart';

class NoteTest {
  static NoteRepository repository = NoteRepository();
  static NoteItem? note ;

  static run() {
    print('==========Start Post tests');

    _add();
    _getAll();
    _get();
    _update();
    _delete();
  }

  static _add() {
    test.test('Add Note', () async {
      NoteItem noteItem = NoteItem(
        userId: UserTest.user.authId,
        title: 'Third Test Of Note',
        description: 'this is a test to see what happen when we add note for third',
        creationDate: DateTime.now(),
        dateTime: DateTime.now(),
        remind: true,
      );
      DocumentSnapshot? doc = await repository.add(noteItem);
      noteItem.document = doc;
      note = noteItem;
      test.expect(doc, test.isNot(null));
    });
  }

  static _getAll(){
    test.test('Get Notes', () async {
      List<NoteItem> notes = await repository.getNotes();
      test.expect(notes, test.isNotEmpty);
    });
  }

  static _get(){
    test.test('Get note', () async{
      NoteItem? noteItem = await repository.getNote(note!.document!.id);
      print('*******CAROLE********');
      print(noteItem.toString());
      test.expect(noteItem, test.isNot(null));
    });
  }

  static _update(){
    test.test('Update Note', () async{
      note!.title = 'update';
      bool res = await repository.update(note!,note!.document!.id);
      test.expect(res, true);
    });
  }

  static _delete(){
    test.test('Delete Note', () async {
      //NoteItem? noteA = await repository.getNote("AW9wfSgLFp3xznJmMHio");
      print('##########PRINT OBJECT###############');
      print(note);
      bool res = await repository.delete(note!);
      test.expect(res, true);
    });
  }
}
