// Activity 5: Customizing UI components with a theme
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const ThemeDemoApp());
}

// 1. The app is Stateful because the dark-mode switch changes the theme
class ThemeDemoApp extends StatefulWidget {
  const ThemeDemoApp({super.key});

  @override
  State<ThemeDemoApp> createState() => _ThemeDemoAppState();
}

class _ThemeDemoAppState extends State<ThemeDemoApp> {
  bool _isDark = false;

  void _setDark(bool value) {
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 5 - Material 3 Theme Showcase',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: SettingsPage(isDark: _isDark, onDarkChanged: _setDark),
    );
  }
}

// 2. One place to customize the look of the WHOLE app
ThemeData buildTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: studentColor,
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: brightness,
    scaffoldBackgroundColor: isLight ? colorScheme.surface : colorScheme.surface,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 2,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.2),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        elevation: 2,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

// 3. The page receives the data and a callback from its parent
class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.isDark,
    required this.onDarkChanged,
  });

  final bool isDark;
  final ValueChanged<bool> onDarkChanged;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Set<String> _selectedSkills = {'Flutter', 'Dart'};
  double _sliderValue = 65.0;
  bool _notificationsEnabled = true;
  int _selectedSegment = 0;
  final TextEditingController _textController = TextEditingController(text: 'Mobile Application Development');

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Format student name nicely
  String _formattedName(String raw) {
    final parts = raw.split('_');
    if (parts.length >= 3) {
      return '${parts[2]} ${parts[1]}';
    }
    return raw.replaceAll('_', ' ');
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String displayName = _formattedName(studentName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity 5 - Theme & Components'),
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: () => widget.onDarkChanged(!widget.isDark),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              // 4. Student Profile Card with Theme Badge
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.primary, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: colors.primaryContainer,
                          foregroundColor: colors.primary,
                          child: const Icon(Icons.person_rounded, size: 32),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    displayName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(Icons.verified_rounded, size: 18, color: colors.primary),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'ID: $studentId • BSIT',
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: colors.primary.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: studentColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Seed: $studentColorName',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: colors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 5. Appearance & Mode Switch
              Card(
                elevation: 2,
                child: SwitchListTile(
                  title: const Text(
                    'Dark Theme Mode',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    widget.isDark ? 'Active: Dark Mode' : 'Active: Light Mode',
                    style: TextStyle(fontSize: 12, color: colors.outline),
                  ),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withAlpha(120),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: colors.primary,
                    ),
                  ),
                  value: widget.isDark,
                  onChanged: widget.onDarkChanged,
                ),
              ),

              const SizedBox(height: 24),

              // 6. Section Header: Interactive Skill Chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Interactive Skills', style: Theme.of(context).textTheme.headlineSmall),
                  Text(
                    '${_selectedSkills.length} selected',
                    style: TextStyle(fontSize: 12, color: colors.primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSkillChip('Dart', Icons.code_rounded),
                  _buildSkillChip('Flutter', Icons.flutter_dash_rounded),
                  _buildSkillChip('Firebase', Icons.local_fire_department_rounded),
                  _buildSkillChip('MySQL', Icons.storage_rounded),
                  _buildSkillChip('Python', Icons.terminal_rounded),
                  _buildSkillChip('Git', Icons.source_rounded),
                  _buildSkillChip('UI/UX', Icons.palette_rounded),
                ],
              ),

              const SizedBox(height: 24),

              // 7. Section Header: Form & Control Components
              Text('Form & Inputs', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: 'Course Subject',
                          prefixIcon: const Icon(Icons.book_rounded),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: () => _textController.clear(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.volume_up_rounded, color: colors.primary),
                          Expanded(
                            child: Slider(
                              value: _sliderValue,
                              min: 0,
                              max: 100,
                              divisions: 20,
                              label: '${_sliderValue.round()}%',
                              onChanged: (value) {
                                setState(() {
                                  _sliderValue = value;
                                });
                              },
                            ),
                          ),
                          Text(
                            '${_sliderValue.round()}%',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable push notifications'),
                        value: _notificationsEnabled,
                        onChanged: (val) {
                          setState(() {
                            _notificationsEnabled = val ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 8. Section Header: Material 3 Button Matrix
              Text('Material 3 Button Components', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),

              // Segmented Button
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('Overview'), icon: Icon(Icons.view_agenda_outlined)),
                  ButtonSegment(value: 1, label: Text('Stats'), icon: Icon(Icons.bar_chart_rounded)),
                  ButtonSegment(value: 2, label: Text('Settings'), icon: Icon(Icons.tune_rounded)),
                ],
                selected: {_selectedSegment},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _selectedSegment = newSelection.first;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Buttons in Grid/Rows
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _showMessage(context, 'FilledButton pressed!'),
                      icon: const Icon(Icons.check_circle_outline_rounded),
                      label: const Text('Filled Button'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showMessage(context, 'ElevatedButton pressed!'),
                      icon: const Icon(Icons.touch_app_rounded),
                      label: const Text('Elevated'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showMessage(context, 'OutlinedButton pressed!'),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Outlined'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () => _showMessage(context, 'Tonal Button pressed!'),
                      icon: const Icon(Icons.auto_awesome_rounded),
                      label: const Text('Tonal'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: () => _showMessage(context, 'Reset all preferences?'),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reset All Settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label, IconData icon) {
    final isSelected = _selectedSkills.contains(label);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return FilterChip(
      avatar: Icon(
        icon,
        size: 16,
        color: isSelected ? colors.onPrimary : colors.primary,
      ),
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedSkills.add(label);
          } else {
            _selectedSkills.remove(label);
          }
        });
      },
      selectedColor: colors.primary,
      labelStyle: TextStyle(
        color: isSelected ? colors.onPrimary : colors.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}