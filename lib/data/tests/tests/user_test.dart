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
    //_update();
    //_getUser();
    //_getFromAuthId();
    //_getCurrentUser();
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


}