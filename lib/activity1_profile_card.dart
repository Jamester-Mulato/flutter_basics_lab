// Activity 1: Your first screen with StatelessWidgets
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const ProfileApp());
}

// 1. The root of the app: a StatelessWidget that sets up MaterialApp
class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 1 - Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: studentColor,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Activity 1 - $studentName'),
          centerTitle: true,
          elevation: 2,
        ),
        body: const Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ProfileCard(),
          ),
        ),
      ),
    );
  }
}

// 2. A reusable card that displays a rich student profile
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  // Helper to format student name nicely (e.g. 'ILDV3_MULATO_JAMESTER' -> 'JAMESTER MULATO')
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

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: Card(
        elevation: 6,
        shadowColor: colors.primary.withAlpha(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: colors.outlineVariant.withAlpha(80), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorative Header Banner
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primary,
                    colors.primaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Icon(
                      Icons.school_rounded,
                      size: 130,
                      color: colors.onPrimary.withAlpha(40),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.surface.withAlpha(200),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.palette_outlined, size: 14, color: colors.primary),
                          const SizedBox(width: 6),
                          Text(
                            '$studentColorName Theme',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Avatar with overlap
            Transform.translate(
              offset: const Offset(0, -48),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surface,
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withAlpha(50),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: colors.primary,
                      child: Icon(
                        Icons.person_rounded,
                        size: 56,
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                  // Online / Verified status indicator
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surface,
                    ),
                    child: const CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check, size: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Information Body
            Transform.translate(
              offset: const Offset(0, -36),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: colors.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'ID: $studentId',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.onSecondaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'BS Information Technology',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Caraga State University',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.outline,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Quick Stats Section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest.withAlpha(120),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ProfileStatItem(label: 'Year', value: '3rd Year'),
                          _VerticalDivider(),
                          _ProfileStatItem(label: 'Units', value: '21 Units'),
                          _VerticalDivider(),
                          _ProfileStatItem(label: 'Status', value: 'Active'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Contact Info Tiles
                    _ContactInfoTile(
                      icon: Icons.email_outlined,
                      label: 'Student Email',
                      value: 'jamester.mulato@carsu.edu.ph',
                    ),
                    const SizedBox(height: 8),
                    _ContactInfoTile(
                      icon: Icons.phone_outlined,
                      label: 'Contact Number',
                      value: '+63 912 345 6789',
                    ),
                    const SizedBox(height: 8),
                    _ContactInfoTile(
                      icon: Icons.school_outlined,
                      label: 'Department',
                      value: 'College of Computing & Info Sciences',
                    ),
                    const SizedBox(height: 8),
                    _ContactInfoTile(
                      icon: Icons.location_on_outlined,
                      label: 'Campus',
                      value: 'Main Campus, Ampayon, Butuan City',
                    ),

                    const SizedBox(height: 20),

                    // Skills Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: [
                        _SkillTag(label: 'Flutter', icon: Icons.flutter_dash),
                        _SkillTag(label: 'Dart', icon: Icons.code),
                        _SkillTag(label: 'UI Design', icon: Icons.draw_outlined),
                        _SkillTag(label: 'Mobile Dev', icon: Icons.smartphone),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Opening email client...'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.send_rounded, size: 18),
                            label: const Text('Contact'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile link copied to clipboard!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: const Text('Share'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStatItem extends StatelessWidget {
  const _ProfileStatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: colors.outline,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}

class _ContactInfoTile extends StatelessWidget {
  const _ContactInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withAlpha(60)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withAlpha(120),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: colors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: colors.outline,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillTag extends StatelessWidget {
  const _SkillTag({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withAlpha(120),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.secondary),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: colors.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
