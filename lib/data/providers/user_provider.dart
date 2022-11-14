import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/models/user_item.dart';
import '../../utils/my_material.dart';

class UserProvider {

  Future<DocumentSnapshot?> add(String authId, Map<String, Object> userMap) async {
    DocumentSnapshot? document;

    try{
       DocumentReference documentReference = FirebaseFirestore.instance
          .collection(COLLECTION_USER)
          .doc(authId);
      await documentReference.set(userMap);
      document = await documentReference.get();
    }catch(err){
      debugPrint('==========Failed to add user: $err');
    }
    return document;
  }

  Future<bool> update(Map<String, Object> userMap, String docId) async {
    bool hasUpdate = false;
    try {
      await FirebaseFirestore.instance
          .collection(COLLECTION_USER)
          .doc(docId)
          .update(userMap);
      hasUpdate = true;
    } catch (err) {
      debugPrint('==========Failed to update user: $err');
    }
    return hasUpdate;
  }
}