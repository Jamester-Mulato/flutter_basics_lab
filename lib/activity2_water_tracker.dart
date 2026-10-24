// Activity 2: A StatefulWidget that changes when you tap
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 2 - Water Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: studentColor,
          brightness: Brightness.light,
        ),
      ),
      home: const WaterTrackerPage(),
    );
  }
}

// 1. The widget itself: it only creates its State object
class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

// 2. The State object: it keeps the data that can change
class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int _glasses = 0;
  static const int _goal = 6;
  static const int _glassMl = 250;

  // 3. Each method changes the data INSIDE setState()
  void _addGlass([int amount = 1]) {
    setState(() {
      _glasses = (_glasses + amount).clamp(0, _goal);
    });
  }

  void _removeGlass() {
    setState(() {
      if (_glasses > 0) _glasses--;
    });
  }

  void _reset() {
    setState(() {
      _glasses = 0;
    });
  }

  String _getMotivationalMessage(bool goalReached) {
    if (goalReached) {
      return '🎉 Fantastic job! You hit your daily hydration goal!';
    } else if (_glasses >= 6) {
      return 'Almost there! Just ${_goal - _glasses} more ${_goal - _glasses == 1 ? "glass" : "glasses"} to go!';
    } else if (_glasses >= 4) {
      return 'Halfway mark conquered! Keep up the momentum!';
    } else if (_glasses > 0) {
      return 'Great start! Drinking water keeps your brain sharp.';
    } else {
      return 'Start your day with a fresh glass of water!';
    }
  }

  // 4. build() draws the screen using the current data
  @override
  Widget build(BuildContext context) {
    debugPrint('build() called: $_glasses glasses');
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool goalReached = _glasses >= _goal;
    final double progress = (_glasses / _goal).clamp(0.0, 1.0);
    final int currentMl = _glasses * _glassMl;
    final int targetMl = _goal * _glassMl;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity 2 - $studentName'),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            tooltip: 'Reset Tracker',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _glasses > 0 ? _reset : null,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Motivation Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: goalReached
                            ? [Colors.teal.shade700, Colors.teal.shade400]
                            : [colors.primary, colors.primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            goalReached
                                ? Icons.emoji_events_rounded
                                : Icons.water_drop_rounded,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goalReached ? 'Daily Goal Achieved' : 'Daily Hydration Tracker',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getMotivationalMessage(goalReached),
                                style: TextStyle(
                                  color: Colors.white.withAlpha(220),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Main Dashboard Card with Radial Gauge
                Card(
                  elevation: 4,
                  shadowColor: colors.primary.withAlpha(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                    child: Column(
                      children: [
                        // Radial Hydration Progress Ring
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 180,
                              height: 180,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 14,
                                backgroundColor: colors.surfaceContainerHighest,
                                color: goalReached ? Colors.teal : colors.primary,
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_drink_rounded,
                                  size: 40,
                                  color: goalReached ? Colors.teal : colors.primary,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(progress * 100).toInt()}%',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                Text(
                                  '$currentMl / $targetMl ml',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: colors.outline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Large Glasses Count
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$_glasses',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: goalReached ? Colors.teal : colors.primary,
                              ),
                            ),
                            Text(
                              ' / $_goal glasses',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Interactive 8-Glass Visual Grid
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: List.generate(_goal, (index) {
                            final bool filled = index < _glasses;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: filled
                                    ? (goalReached
                                        ? Colors.teal.withAlpha(40)
                                        : colors.primary.withAlpha(40))
                                    : colors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: filled
                                      ? (goalReached ? Colors.teal : colors.primary)
                                      : colors.outlineVariant.withAlpha(60),
                                  width: filled ? 1.5 : 1,
                                ),
                              ),
                              child: Icon(
                                filled
                                    ? Icons.water_drop_rounded
                                    : Icons.water_drop_outlined,
                                size: 22,
                                color: filled
                                    ? (goalReached ? Colors.teal : colors.primary)
                                    : colors.outlineVariant,
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 28),

                        // Quick Control Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Minus Button
                            IconButton.filledTonal(
                              onPressed: _glasses > 0 ? _removeGlass : null,
                              icon: const Icon(Icons.remove_rounded),
                              iconSize: 28,
                              padding: const EdgeInsets.all(14),
                              tooltip: 'Remove 1 glass',
                            ),
                            const SizedBox(width: 16),

                            // Main Add 1 Glass Button
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: _glasses < _goal ? () => _addGlass(1) : null,
                                icon: const Icon(Icons.add_rounded, size: 24),
                                label: const Text(
                                  '+1 Glass (250ml)',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Secondary Quick Actions: Bottle (+2) & Reset
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _glasses <= _goal - 2 ? () => _addGlass(2) : null,
                                icon: const Icon(Icons.local_drink_outlined, size: 18),
                                label: const Text('+2 Bottle (500ml)'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            TextButton.icon(
                              onPressed: _glasses > 0 ? _reset : null,
                              icon: const Icon(Icons.restart_alt_rounded, size: 18),
                              label: const Text('Reset'),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Health Tip Banner Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colors.outlineVariant.withAlpha(60)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_outline_rounded, color: colors.primary, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Drinking water boosts cognitive function, improves skin hydration, and balances physical energy.',
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}