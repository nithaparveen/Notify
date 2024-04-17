import 'package:hive/hive.dart';

part 'note_card_model.g.dart';

@HiveType(typeId: 0)
class NoteCardModel {
  @HiveField(0)
  late String category;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String description;
  @HiveField(3)
  late DateTime date;
  NoteCardModel(
      {required this.category,
        required this.title,
        required this.description,
        required this.date});
  NoteCardModel.copy(NoteCardModel other) {
    category = other.category;
    title = other.title;
    description = other.description;
    date = other.date;
  }
}