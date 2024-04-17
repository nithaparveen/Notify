import 'package:flutter/material.dart';


import '../../../../global_widget/color_constants.dart';
import '../../../../global_widget/global_textstyles.dart';
import '../note_card_fullview/note_card_fullview.dart';

class NoteCard extends StatefulWidget {
  const NoteCard(
      {super.key,
        this.onEditPressed,
        this.onDeletePressed,
        required this.category,
        required this.title,
        required this.description,
        required this.date});

  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final String category;
  final String title;
  final String description;
  final String date;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return NoteCardFullView(
                category: widget.category,
                title: widget.title,
                description: widget.description,
                date: widget.date,
              );
            },
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: primarycolorlight,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xffAF8260), Color(0xff803D3B)]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          widget.category,
                          style: subtextlight,
                        ),
                      )),
                  Row(
                    children: [
                      IconButton(
                          onPressed: widget.onEditPressed,
                          icon: Icon(
                            Icons.edit,
                            color: primarycolordark,
                          )),
                      IconButton(
                          onPressed: widget.onDeletePressed,
                          icon: Icon(
                            Icons.delete,
                            color: primarycolordark,
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.title,
                style: maintextdark,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: subtextdark,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.date,
                    style: subtextdark,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}