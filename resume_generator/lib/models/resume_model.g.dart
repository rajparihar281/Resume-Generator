// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResumeDataAdapter extends TypeAdapter<ResumeData> {
  @override
  final int typeId = 0;

  @override
  ResumeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResumeData(
      name: fields[0] as String,
      skills: (fields[1] as List).cast<String>(),
      projects: (fields[2] as List).cast<String>(),
      email: fields[3] as String?,
      phone: fields[4] as String?,
      experience: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResumeData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.skills)
      ..writeByte(2)
      ..write(obj.projects)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.experience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
