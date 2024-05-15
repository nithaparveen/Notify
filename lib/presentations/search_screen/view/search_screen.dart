import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notify/core/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../../global_widget/color_constants.dart';
import '../../../core/constants/global_textstyles.dart';
import '../../home_screen/controller/note_card_controller.dart';
import '../../home_screen/widgets/note_card_fullview/note_card_fullview.dart';
import '../controller/search_screen_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var noteCardController = context.read<NoteCardController>();
    var searchScreenController = context.read<SearchScreenController>();
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(top: 13),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40, left: 50, right: 30),
          child: TextField(
            cursorColor: Colors.grey,
            autofocus: true,
            controller: searchController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {});
              }
              noteCardController.filterNotes(value);
              setState(() {});
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.brown)),
              contentPadding: EdgeInsets.only(left: 15),
              hintText: "Search for Notes",
              hintStyle: subtextgrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<NoteCardController>(
        builder: (context, noteController, _) {
          if (searchController.text.isEmpty) {
            return FutureBuilder<List<String>>(
              future: searchScreenController.getRecentSearches(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No Data Found',
                          style: TextStyle(color: Colors.grey, fontSize: 20)));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Text("Recent Searches", style: subtextdark),
                        SizedBox(height: 15),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final recentSearch = snapshot.data![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    searchController.text = recentSearch;
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(recentSearch, style: subtextdark),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: 20,
                                          color: primarycolordark,
                                        ),
                                        onPressed: () async {
                                          await searchScreenController
                                              .removeRecentSearch(recentSearch);
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            final filteredNotes = noteController.notes
                .where((note) => note.title
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
                .toList();
            if (filteredNotes.isEmpty) {
              return Center(
                  child: Text(
                'No Data Found',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];
                        return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoteCardFullView(
                                      category: note.category,
                                      title: note.title,
                                      description: note.description,
                                      date: DateFormat('dd-MM-yyyy')
                                          .format(note.date),
                                    )));
                            searchScreenController
                                .addRecentSearch(searchController.text);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        note.category,
                                        style: subtextbrown,
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  note.title,
                                  style: titletext,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(note.date),
                                      style: subtextdark,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
