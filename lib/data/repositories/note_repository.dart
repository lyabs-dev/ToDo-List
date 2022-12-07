
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/providers/note_provider.dart';

import '../models/note_item.dart';

class NoteRepository {
  NoteProvider provider = NoteProvider();

  Future<DocumentSnapshot?> add(NoteItem note)async{
    return await provider.add(note.toMap());
  }

  Future<List<NoteItem>> getNotes(String userId,{DocumentSnapshot? startAfter, int? limit})async{
    List<NoteItem> notes = [];

    List<Map> list = await provider.getUserNotes(userId,limit: limit, startAfter: startAfter);
    for(Map map in list){
      NoteItem? note = NoteItem.fromMap(map);
      if(note != null){
        notes.add(note);
      }
    }
    return notes ;
  }

  Future<bool?> isTitleExist(String title) async {
    return await provider.isTitleExist(title);
  }

  Future<NoteItem?> getNote(String docId,{enableCache:false})async{
    Map map = await provider.getNote(docId);
    print('********Lina**********');
    print(map);
    return NoteItem.fromMap(map);
  }

  Future<bool> update(NoteItem noteItem, String docId)async{
    if(noteItem.document != null){
      return provider.update(docId, noteItem.toMap());
    }
    return false;
  }

  Future<bool> delete(NoteItem noteItem)async{
    return await provider.delete(noteItem.document!.id);
  }

}