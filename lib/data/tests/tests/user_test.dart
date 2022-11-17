import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_item.dart';
import '../../repositories/user_repository.dart';
import 'package:test/test.dart' as test;


class UserTest {
  static UserItem user = UserItem(
    authId: 'wertyuiokltyu',
    name: 'jonathan',
    email: 'jokalmwamba@gmail.com'
  );

  static UserRepository repository = UserRepository();

  static run() {
    print('=========Start User Test=========');

    _add();
    _update();
    _getUser();
    _getFromAuthId();
    _getCurrentUser();
  }

  static _add() {
    test.test('Add', () async {
      DocumentSnapshot? document = await repository.add(user);
      user.document = document;
      print('###########print document##############');
      print(document);
      test.expect(document, test.isNot(null));
    });
  }

  static _update() {
    test.test('Update user', () async {
      user.name = 'jonnathan442';
      bool res = await repository.update(user, user.authId);
      test.expect(res, true);
    });
  }

  static _getUser() {
    test.test('Get user', () async {
      UserItem? user = await repository.get(UserTest.user.authId);
      test.expect(user, test.isNot(null));
    });
  }

  static _getFromAuthId() {
    test.test('Get user from auth ID', () async {
      UserItem? user = await repository.getFromAuthId(UserTest.user.authId);

      if (user != null) {
        UserTest.user = user;
      }
      test.expect(user, test.isNot(null));
    });
  }

  static _getCurrentUser(){
    test.test('Get user current ', ()async{
      await repository.setCurrentUser(UserTest.user);
      UserItem? user = await repository.getCurrentUser();
      if(user != null){
        UserTest.user = user;
      }
      test.expect(user, test.isNot(null));
    });
  }


}