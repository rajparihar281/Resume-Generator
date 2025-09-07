import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/resume_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/resume_display.dart';
import '../widgets/customization_panel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch resume data on app start
    Future.microtask(
      () => ref.read(resumeProvider.notifier).fetchResumeFromApi(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(resumeProvider);
    final settings = ref.watch(settingsProvider);
    final locationAsync = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Generator'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          // GPS Location Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child: locationAsync.when(
              data: (position) => position != null
                  ? Text(
                      'GPS: ${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12),
                    )
                  : const Text('GPS: N/A', style: TextStyle(fontSize: 12)),
              loading: () => const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              error: (_, __) =>
                  const Text('GPS: Error', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Customization Panel
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const CustomizationPanel(),
          ),
          // Resume Display
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: resume != null
                  ? ResumeDisplay(resume: resume, settings: settings)
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading resume data...'),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(resumeProvider.notifier).fetchResumeFromApi(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
