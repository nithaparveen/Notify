import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notify/presentations/settings_screen/view/search_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../global_widget/color_constants.dart';
import '../../../global_widget/global_textstyles.dart';
import '../../../repository/note_card_model/note_card_model.dart';
import '../../search_screen/view/search_screen.dart';
import '../controller/note_card_controller.dart';
import '../widgets/drawer/privacypolicy.dart';
import '../widgets/drawer/support.dart';
import '../widgets/drawer/termsandconditions.dart';
import '../widgets/note_card/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  Color selectedColor = Colors.grey;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    context.read<NoteCardController>().loadEvents();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerWatch = context.watch<NoteCardController>();
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Text(
          'NOtifY',
          style: browntitle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingScreen(),
                    ));
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: Consumer<NoteCardController>(
        builder: (context, value, child) {
          return isloading
              ? Center(
                  child: CircularProgressIndicator(
                  color: primarycolordark,
                ))
              : value.notes.isEmpty
                  ? Center(
                      child: Text(
                      'No Data Found',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.notes.length,
                            itemBuilder: (context, index) {
                              final dateFormatter = DateFormat('dd-MM-yyyy');
                              final note = value.notes[index];
                              final date =
                                  dateFormatter.format(note.date.toLocal());
                              return NoteCard(
                                onEditPressed: () {
                                  value.existingNoteIndex = index;
                                  _addOrEditNote(context, existingNote: note);
                                },
                                onDeletePressed: () async {
                                  await value.deleteEvent(index);
                                  value.loadEvents();
                                },
                                category: note.category,
                                title: note.title,
                                description: note.description,
                                date: date,
                              );
                            },
                          ),
                        ),
                      ],
                    );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
            backgroundColor: Color(0xff803D3B),
            onPressed: () {
              providerWatch.existingNoteIndex = -1;
              _addOrEditNote(context);
            },
            child: Icon(
              Icons.add,
              color: primarycolorlight,
              size: 40,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addOrEditNote(BuildContext ctx, {NoteCardModel? existingNote}) async {
    var providerRead = context.read<NoteCardController>();
    final isEditing = existingNote != null;
    final newNote = isEditing
        ? NoteCardModel.copy(existingNote)
        : NoteCardModel(
            category: '',
            title: '',
            description: '',
            date: DateTime.now(),
          );

    _categoryController.text = newNote.category;
    _titleController.text = newNote.title;
    _descriptionController.text = newNote.description;
    final dateFormatter = DateFormat('dd-MM-yyyy');
    _dateController.text =
        isEditing ? dateFormatter.format(newNote.date.toLocal()) : '';

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            backgroundColor: bgcolor,
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    AppBar(
                      backgroundColor: bgcolor,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: primarycolordark,
                          )),
                      centerTitle: true,
                      title: Text(isEditing ? 'Edit Note' : 'Add Note',
                          style: maintextdark20),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Category',
                          labelStyle: subtextdark),
                      controller: _categoryController,
                      onChanged: (value) {
                        newNote.category = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                          labelStyle: subtextdark),
                      controller: _titleController,
                      onChanged: (value) {
                        newNote.title = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: subtextdark),
                      controller: _descriptionController,
                      onChanged: (value) {
                        newNote.description = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: newNote.date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            newNote.date = selectedDate.toUtc();
                            _dateController.text =
                                dateFormatter.format(newNote.date.toLocal());
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date (dd-MM-yyyy)',
                              labelStyle: subtextdark),
                          controller: _dateController,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff803D3B))),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: subtextlight,
                          ),
                        ),
                        SizedBox(width: 60),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff803D3B))),
                          onPressed: () async {
                            if (_categoryController.text.isNotEmpty &&
                                _titleController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty) {
                              newNote.category = _categoryController.text;
                              newNote.title = _titleController.text;
                              newNote.description = _descriptionController.text;
                              if (isEditing) {
                                await providerRead.updateEvent(
                                    providerRead.existingNoteIndex, newNote);
                              } else {
                                await providerRead.addEvent(newNote);
                              }
                              providerRead.loadEvents();
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.grey,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  backgroundColor: primarycolorlight,
                                  content: Center(
                                    child: Text(
                                      "Please add full details ! ",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            isEditing ? 'Save' : 'Add',
                            style: subtextlight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
