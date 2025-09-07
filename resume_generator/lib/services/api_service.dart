import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/resume_model.dart';

class ApiService {
  static const String baseUrl =
      'http://192.168.1.35:3000';

  Future<ResumeData> fetchResumeData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/resume?name=Sarah Johnson'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResumeData.fromJson(data);
      } else {
        throw Exception('Failed to load resume data');
      }
    } catch (e) {
      // Return default data if API fails
      return ResumeData(
        name: 'John Doe',
        skills: ['Flutter', 'Dart', 'Mobile Development', 'REST APIs', 'Git'],
        projects: [
          'Resume Generator - Flutter app with customizable themes',
          'E-commerce App - Full-stack mobile application',
          'Weather App - Real-time weather data integration',
        ],
        email: 'john.doe@email.com',
        phone: '+1 (555) 123-4567',
        experience: '3+ years in mobile app development',
      );
    }
  }
}
