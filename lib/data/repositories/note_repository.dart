
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/providers/note_provider.dart';

import '../models/note_item.dart';

class NoteRepository {
  NoteProvider provider = NoteProvider();

  Future<DocumentSnapshot?> add(NoteItem note)async{
    return await provider.add(note.toMap());
  }

  Future<List<NoteItem>> getPosts({DocumentSnapshot? startAfter, int? limit})async{
    List<NoteItem> notes = [];

    List<Map> list = await provider.getNotes(limit: limit, startAfter: startAfter);
    for(Map map in list){
      NoteItem? note = NoteItem.fromMap(map);
      if(note != null){
        notes.add(note);
      }
    }
    return notes ;
  }

  Future<NoteItem?> getPost(String docId,{enableCache:false})async{
    Map map = await provider.getPost(docId);
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