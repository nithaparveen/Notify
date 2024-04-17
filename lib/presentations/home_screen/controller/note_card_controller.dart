import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../repository/note_card_model/note_card_model.dart';

class NoteCardController with ChangeNotifier {
  final Box<NoteCardModel> _noteBox = Hive.box('testBox');
  List<NoteCardModel> notes = [];

  int existingNoteIndex = -1;
  //load data
  Future<List<NoteCardModel>> getNotes() async {
    return _noteBox.values.toList();
  }

  Future<void> loadEvents() async {
    final getNote = await getNotes();
    notes = getNote;
    notifyListeners();
  }

//Add event
  Future<void> addEvent(NoteCardModel event) async {
    await _noteBox.add(event);
    notifyListeners();
  }

//Delete event
  Future<void> deleteEvent(int index) async {
    await _noteBox.deleteAt(index);
    notifyListeners();
  }

//Update event
  Future<void> updateEvent(int index, NoteCardModel updateNote) async {
    await _noteBox.putAt(index, updateNote);
    notifyListeners();
  }

  void filterNotes(String query) async {
    if (query.isEmpty) {
      // If the search query is empty, show all notes
      notes = await getNotes();
    } else {
      // Otherwise, filter notes based on the search query
      final allNotes = await getNotes();
      notes = allNotes.where((note) {
        return note.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}