import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../providers/settings_provider.dart';

class CustomizationPanel extends ConsumerWidget {
  const CustomizationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Column(
      children: [
        // Font Size Slider
        Row(
          children: [
            const Text('Font Size: '),
            Text('${settings.fontSize.toInt()}'),
            Expanded(
              child: Slider(
                value: settings.fontSize,
                min: 12,
                max: 24,
                divisions: 12,
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).updateFontSize(value),
              ),
            ),
          ],
        ),

        // Color Pickers Row
        Row(
          children: [
            Expanded(
              child: _buildColorButton(
                context,
                ref,
                'Font Color',
                settings.fontColorValue,
                (color) => ref
                    .read(settingsProvider.notifier)
                    .updateFontColor(color.value),
                Icons.text_fields,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildColorButton(
                context,
                ref,
                'Bg Color',
                settings.backgroundColorValue,
                (color) => ref
                    .read(settingsProvider.notifier)
                    .updateBackgroundColor(color.value),
                Icons.format_color_fill,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColorButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    Color currentColor,
    Function(Color) onColorChanged,
    IconData icon,
  ) {
    return ElevatedButton.icon(
      onPressed: () => _showColorPicker(context, currentColor, onColorChanged),
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: currentColor,
        foregroundColor: _getContrastColor(currentColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _showColorPicker(
    BuildContext context,
    Color currentColor,
    Function(Color) onColorChanged,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: onColorChanged,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
