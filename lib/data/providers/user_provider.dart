import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/models/user_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<Map> get(String documentId) async {
    Map map = {};

    try {
      var result = await FirebaseFirestore.instance
          .collection(COLLECTION_USER)
          .doc(documentId)
          .get();
      if (result.data() != null) {
        map = result.data()!;
        map[FIELD_USER_DOCUMENT] = result;
      }
    } catch (err) {
      debugPrint('=======Failed to get user:$err');
    }
    return map;
  }

  Future<Map> getFromEmail(String email) async {
    Map map = {};

    try {
      var result = await FirebaseFirestore.instance.collection(COLLECTION_USER)
          .where(FIELD_USER_EMAIL, isEqualTo: email.toLowerCase())
          .get();
      if (result.docs.isNotEmpty) {
        map = result.docs.first.data();
        map[FIELD_USER_DOCUMENT] = result.docs.first;
      }
    }
    catch (err) {
      debugPrint('=======Failed to get user from email: $err');
    }

    return map;
  }


  Future<Map> getFromAuthId(String authId) async {
    Map map = {};

    try {
      var result = await FirebaseFirestore.instance
          .collection(COLLECTION_USER)
          .where(FIELD_USER_AUTH_ID, isEqualTo: authId)
          .get();
      if (result.docs.isNotEmpty) {
        map = result.docs.first.data();
        map[FIELD_USER_DOCUMENT] = result.docs.first;
      }
    } catch (err) {
      debugPrint('===========Failed to get user from auth ID : $err');
    }
    return map;
  }

  //check if username already exists
  Future<bool?> isUserExist(String username) async {
    bool? isExist;

    try {
      var result = await FirebaseFirestore.instance.collection(COLLECTION_USER)
          .where(FIELD_USER_NAME, isEqualTo: username.toLowerCase())
          .get();
      isExist = result.docs.isNotEmpty;
    }
    catch (err) {
      debugPrint('=======Failed to check if user exists: $err');
    }

    return isExist;
  }

  Future<Map<String, Object>> getCurrentUser() async {
    Map<String, Object> result = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(PREF_CURRENT_USER);

    if (userString != null) {
      try {
        result = json.decode(userString);
      } catch (err) {
        debugPrint("============Failed to get current user: $err");
      }
    }
    return result;
  }

  Future setCurrentUser(Map<String, Object> map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_CURRENT_USER, json.encode(map));
  }

}


