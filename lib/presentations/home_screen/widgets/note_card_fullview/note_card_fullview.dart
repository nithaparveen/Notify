import 'package:flutter/material.dart';
import '../../../../global_widget/color_constants.dart';
import '../../../../global_widget/global_textstyles.dart';

class NoteCardFullView extends StatefulWidget {
  const NoteCardFullView(
      {super.key,
        required this.category,
        required this.title,
        required this.description,
        this.date});
  final String category;
  final String title;
  final String description;
  final String? date;

  @override
  State<NoteCardFullView> createState() => _NoteCardFullViewState();
}

class _NoteCardFullViewState extends State<NoteCardFullView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolorlight,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primarycolordark,
          ),
        ),
        backgroundColor: primarycolorlight,
        centerTitle: true,
        title: Text(widget.title, style: maintextdark),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.red]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          widget.category,
                          style: subtextlight,
                        ),
                      )),
                  Text(widget.date.toString(), style: maintextdark),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3,
                color: primarycolordark,
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.description,
                  textAlign: TextAlign.justify, style: subtextdark),
            ],
          ),
        ),
      ]),
    );
  }
}