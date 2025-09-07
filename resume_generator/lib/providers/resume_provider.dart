import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/resume_model.dart';
import '../services/api_service.dart';

final resumeProvider = StateNotifierProvider<ResumeNotifier, ResumeData?>((
  ref,
) {
  return ResumeNotifier();
});

class ResumeNotifier extends StateNotifier<ResumeData?> {
  ResumeNotifier() : super(null) {
    loadResumeFromLocal();
  }

  final Box<ResumeData> _resumeBox = Hive.box<ResumeData>('resume');

  void loadResumeFromLocal() {
    final resume = _resumeBox.get('current_resume');
    if (resume != null) {
      state = resume;
    }
  }

  Future<void> fetchResumeFromApi() async {
    try {
      final apiService = ApiService();
      final resumeData = await apiService.fetchResumeData();
      state = resumeData;
      await _resumeBox.put('current_resume', resumeData);
    } catch (e) {
      print('Error fetching resume: $e');
    }
  }

  void updateResume(ResumeData resume) {
    state = resume;
    _resumeBox.put('current_resume', resume);
  }
}
