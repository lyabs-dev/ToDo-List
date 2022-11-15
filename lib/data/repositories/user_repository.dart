

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_structure/data/providers/user_provider.dart';
import '../../utils/my_material.dart';
import '../models/user_item.dart';

class UserRepository {

  UserProvider userProvider = UserProvider();

  Future<DocumentSnapshot?> add(UserItem user) async {
    DocumentSnapshot? document = await userProvider.add(user.authId, user.toMap());
    return document;
  }

  Future<bool> update(UserItem user, String docId) async {
    return await userProvider.update(user.toMap(), docId);
  }

  Future<UserItem?> get(String docId) async {
    Map map = await userProvider.get(docId);
    return UserItem.fromMap(map);
  }

  Future<UserItem?> getFromAuthId(String authId) async {
    Map map = await userProvider.getFromAuthId(authId);
    return UserItem.fromMap(map);
  }

  Future setCurrentUser(UserItem userItem)async{
    await userProvider.setCurrentUser(userItem.toMap());
  }

  Future<UserItem?> getCurrentUser() async{
    UserItem? user;

    Map<String, dynamic> map = await userProvider.getCurrentUser();
    try{
      user = UserItem.fromMap(map);
    }catch(err){
      debugPrint('==============Failed to get current user: $err');
    }
    return user;
  }
}