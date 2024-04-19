import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notify/core/constants/colors.dart';


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
            border: Border.all(color: Colors.black54),
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
                      decoration: BoxDecoration(color: ColorConstants.lightbrown,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.zero,topLeft: Radius.zero,bottomRight: Radius.circular(10),topRight: Radius.zero)),
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
                            color: ColorConstants.brown,
                          )),
                      IconButton(
                          onPressed: widget.onDeletePressed,
                          icon: Icon(
                            Icons.delete,
                            color: ColorConstants.brown,
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
                style: titletext,
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
                  style: subtextgrey16,
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