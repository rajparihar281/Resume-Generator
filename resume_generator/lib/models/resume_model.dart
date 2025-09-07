import 'package:hive/hive.dart';

part 'resume_model.g.dart';

@HiveType(typeId: 0)
class ResumeData extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> skills;

  @HiveField(2)
  List<String> projects;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? phone;

  @HiveField(5)
  String? experience;

  ResumeData({
    required this.name,
    required this.skills,
    required this.projects,
    this.email,
    this.phone,
    this.experience,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      name: json['name'] ?? 'Raj Parihar',
      skills: List<String>.from(
        json['skills'] ?? ['Flutter', 'Dart', 'Mobile Development'],
      ),
      projects: List<String>.from(
        json['projects'] ?? ['Sample Project - Mobile app development'],
      ),
      email: json['email'],
      phone: json['phone'],
      experience: json['experience'],
    );
  }
}
