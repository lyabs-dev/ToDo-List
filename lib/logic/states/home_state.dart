import '../../data/models/note_item.dart';
import '../../utils/my_material.dart';

class HomeState {
  TextEditingController TitleEditingController = TextEditingController(),DescriptionEditingController = TextEditingController();
  List<NoteItem> notes;
  int? noteNumber;
  NoteItem? currentNote;

  HomeState({this.noteNumber ,this.notes = const [], this.currentNote});

  HomeState copy() {
    HomeState copy = HomeState(noteNumber:noteNumber, notes:notes);

    return copy;
  }
}