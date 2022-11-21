import 'package:flutter_structure/data/tests/tests/note_test.dart';
import 'package:flutter_structure/data/tests/tests/settings_test.dart';
import 'package:flutter_structure/data/tests/tests/user_test.dart';

class AppTest {

  static run() {
    //SettingsTest.run();
    UserTest.run();
    NoteTest.run();
  }

}