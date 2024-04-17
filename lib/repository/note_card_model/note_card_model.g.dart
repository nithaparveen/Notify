// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteCardModelAdapter extends TypeAdapter<NoteCardModel> {
  @override
  final int typeId = 0;

  @override
  NoteCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteCardModel(
      category: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteCardModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NoteCardModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}