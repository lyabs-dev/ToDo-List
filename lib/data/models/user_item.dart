import 'package:cloud_firestore/cloud_firestore.dart';


const COLLECTION_USER = 'user';
const FIELD_USER_AUTH_ID = 'auth_id';
const FIELD_USER_EMAIL = 'email';
const FIELD_USER_NAME = 'name';
const FIELD_USER_DOCUMENT = 'document';

class UserItem {
  final String authId;
  final String name;
  final String email;
  final DocumentSnapshot? document;

  const UserItem({
  this.authId:'',
  required this.name,
  required this.email,
  this.document});

  static UserItem? fromMap(Map map) {
    UserItem? user;

    if (map[FIELD_USER_AUTH_ID] != null &&
        map[FIELD_USER_EMAIL] != null &&
        map[FIELD_USER_NAME] != null ) {

      user = UserItem(
          authId: map[FIELD_USER_AUTH_ID],
          name: map[FIELD_USER_NAME],
          email: map[FIELD_USER_EMAIL],
          document: map[FIELD_USER_DOCUMENT]);
    }
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      FIELD_USER_AUTH_ID: authId,
      FIELD_USER_EMAIL: email,
      FIELD_USER_NAME: name,
    };
  }

}