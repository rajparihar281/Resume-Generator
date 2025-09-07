import 'package:flutter/material.dart';
import '../models/resume_model.dart';
import '../models/settings_model.dart';

class ResumeDisplay extends StatelessWidget {
  final ResumeData resume;
  final UserSettings settings;

  const ResumeDisplay({super.key, required this.resume, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: settings.backgroundColorValue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(
              resume.name.toUpperCase(),
              style: TextStyle(
                fontSize: settings.fontSize + 6,
                fontWeight: FontWeight.bold,
                color: settings.fontColorValue,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Divider(color: settings.fontColorValue, thickness: 2),
            const SizedBox(height: 16),

            // Contact Info
            if (resume.email != null || resume.phone != null) ...[
              _buildSection('CONTACT', [
                if (resume.email != null) '📧 ${resume.email}',
                if (resume.phone != null) '📱 ${resume.phone}',
              ]),
              const SizedBox(height: 16),
            ],

            // Experience
            if (resume.experience != null) ...[
              _buildSection('EXPERIENCE', [resume.experience!]),
              const SizedBox(height: 16),
            ],

            // Skills
            _buildSection('SKILLS', resume.skills),
            const SizedBox(height: 16),

            // Projects
            _buildSection('PROJECTS', resume.projects),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: settings.fontSize + 2,
            fontWeight: FontWeight.bold,
            color: settings.fontColorValue,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Container(height: 2, width: 50, color: settings.fontColorValue),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '• $item',
              style: TextStyle(
                fontSize: settings.fontSize,
                color: settings.fontColorValue,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
