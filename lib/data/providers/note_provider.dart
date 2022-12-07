import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/models/note_item.dart';
import '../../utils/my_material.dart';


class NoteProvider {

  static Query queryGetNotes(DocumentSnapshot? startAfter, int? limit) {
    Query query = FirebaseFirestore.instance.collection(COLLECTION_NOTE);

    query = query.orderBy(FIELD_NOTE_CREATION_DATE, descending: true);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    if (limit != null) {
      query = query.limit(limit);
    }
    return query;
  }

  static Query queryGetUserNotes(String userid,DocumentSnapshot? startAfter, int? limit) {
    Query query = FirebaseFirestore.instance.collection(COLLECTION_NOTE)
      .where(FIELD_USER_ID, isEqualTo: userid)
      .orderBy(FIELD_NOTE_CREATION_DATE, descending: true);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    if (limit != null) {
      query = query.limit(limit);
    }
    return query;
  }



  Future<DocumentSnapshot?> add(Map<String, Object> map) async {
    DocumentSnapshot? document;
    try {
      DocumentReference documentReference =
      await FirebaseFirestore.instance.collection(COLLECTION_NOTE).add(map);
      document = await documentReference.get();
    } catch (err) {
      debugPrint('=========Failed to add post: $err');
    }
    return document;
  }

  Future<List<Map>> getNotes({DocumentSnapshot? startAfter, int? limit}) async {
    List<Map> list = [];

    try {
      var result = await queryGetNotes(startAfter, limit).get();
      if (result.docs.isNotEmpty) {
        for (DocumentSnapshot document in result.docs) {
          Map map = document.data() as Map;
          map[FIELD_NOTE_DOCUMENT] = document;
          list.add(map);
        }
      }
    } catch (err) {
      debugPrint('=========Failed to get posts: $err');
    }
    return list;
  }

  Future<List<Map>> getUserNotes(String userId,{DocumentSnapshot? startAfter, int? limit}) async {
    List<Map> list = [];

    try {
      var result = await queryGetUserNotes(userId,startAfter, limit).get();
      if (result.docs.isNotEmpty) {
        for (DocumentSnapshot document in result.docs) {
          Map map = document.data() as Map;
          map[FIELD_NOTE_DOCUMENT] = document;
          list.add(map);
        }
      }
    } catch (err) {
      debugPrint('=========Failed to get posts: $err');
    }
    return list;
  }


  Future<Map> getNote(String documentId) async {
    Map map = {};

    try {
      var result = await FirebaseFirestore.instance
          .collection(COLLECTION_NOTE)
          .doc(documentId)
          .get();
      if (result.data() != null) {
        map = result.data()!;
        map[FIELD_NOTE_DOCUMENT] = result;
      }
    } catch (err) {
      debugPrint('=========Failed to get post: $err');
    }
    return map;
  }

  //check if username already exists
  Future<bool?> isTitleExist(String title) async {
    bool? isExist;

    try {
      var result = await FirebaseFirestore.instance.collection(COLLECTION_NOTE)
          .where(FIELD_NOTE_TITLE, isEqualTo: title.toLowerCase())
          .get();
      isExist = result.docs.isNotEmpty;
    }
    catch (err) {
      debugPrint('=======Failed to check if user exists: $err');
    }

    return isExist;
  }

  Future<bool> update(String docId, Map<String, Object> map) async {
    try {
      await FirebaseFirestore.instance
          .collection(COLLECTION_NOTE)
          .doc(docId)
          .update(map);
      return true;
    } catch (err) {
      debugPrint('==========Failed to update post: $err');
    }

    return false;
  }

  Future<bool> delete(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(COLLECTION_NOTE)
          .doc(docId)
          .delete();
      return true;
    } catch (err) {
      debugPrint('=========Failed to delete post $err');
    }

    return false;
  }
}