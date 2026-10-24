// Activity 3: Basic layouts with Container, Row, Column and Expanded
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 3 - Weather Forecast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: studentColor,
          brightness: Brightness.light,
        ),
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity 3 - Weather Dashboard'),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            tooltip: 'Search City',
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('City search coming soon!')),
              );
            },
          ),
          IconButton(
            tooltip: 'Refresh Weather',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Weather data updated.')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header: Hero Gradient Weather Card
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.primary, colors.primaryContainer],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withAlpha(60),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Location & Date Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_rounded, size: 20, color: colors.onPrimary),
                              const SizedBox(width: 6),
                              Text(
                                'Butuan City',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colors.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: colors.onPrimary.withAlpha(40),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Today, Oct 22',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colors.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Weather Condition & Main Temperature
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '31°C',
                                style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: colors.onPrimary,
                                  letterSpacing: -1,
                                ),
                              ),
                              Text(
                                'Sunny & Clear Skies',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: colors.onPrimary.withAlpha(230),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Feels like 34°C • H: 33° L: 25°',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colors.onPrimary.withAlpha(190),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.withAlpha(40),
                            ),
                            child: const Icon(
                              Icons.wb_sunny_rounded,
                              size: 72,
                              color: Colors.amberAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 2. Four boxes that share the width equally (Expanded)
                const Row(
                  children: [
                    Expanded(
                      child: StatBox(
                        icon: Icons.water_drop_rounded,
                        label: 'Humidity',
                        value: '70%',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        icon: Icons.air_rounded,
                        label: 'Wind',
                        value: '12 km/h',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        icon: Icons.umbrella_rounded,
                        label: 'Rain',
                        value: '10%',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        icon: Icons.thermostat_rounded,
                        label: 'Feels like',
                        value: '35°',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Additional Secondary Metrics Row
                const Row(
                  children: [
                    Expanded(
                      child: StatBox(
                        icon: Icons.wb_twilight_rounded,
                        label: 'UV Index',
                        value: '6 High',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        icon: Icons.speed_rounded,
                        label: 'Pressure',
                        value: '1012 hPa',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        icon: Icons.visibility_rounded,
                        label: 'Visibility',
                        value: '10 km',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 3. Hourly Forecast Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hourly Forecast',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Next 24 hours',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Horizontally scrollable hourly forecast
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      HourForecast(time: 'Now', icon: Icons.wb_sunny_rounded, temp: '31°'),
                      SizedBox(width: 10),
                      HourForecast(time: '1 PM', icon: Icons.wb_sunny_rounded, temp: '32°'),
                      SizedBox(width: 10),
                      HourForecast(time: '2 PM', icon: Icons.wb_cloudy_rounded, temp: '31°'),
                      SizedBox(width: 10),
                      HourForecast(time: '3 PM', icon: Icons.thunderstorm_rounded, temp: '28°'),
                      SizedBox(width: 10),
                      HourForecast(time: '4 PM', icon: Icons.cloud_rounded, temp: '27°'),
                      SizedBox(width: 10),
                      HourForecast(time: '5 PM', icon: Icons.water_drop_rounded, temp: '26°'),
                      SizedBox(width: 10),
                      HourForecast(time: '6 PM', icon: Icons.nights_stay_rounded, temp: '25°'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 4. 5-Day Weekly Forecast Section
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '5-Day Outlook',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        const _DayForecastRow(
                          day: 'Today',
                          condition: 'Sunny',
                          icon: Icons.wb_sunny_rounded,
                          iconColor: Colors.amber,
                          minTemp: '25°',
                          maxTemp: '33°',
                          progress: 0.8,
                        ),
                        Divider(color: colors.outlineVariant.withAlpha(50)),
                        const _DayForecastRow(
                          day: 'Tomorrow',
                          condition: 'Partly Cloudy',
                          icon: Icons.cloud_queue_rounded,
                          iconColor: Colors.blueGrey,
                          minTemp: '24°',
                          maxTemp: '31°',
                          progress: 0.7,
                        ),
                        Divider(color: colors.outlineVariant.withAlpha(50)),
                        const _DayForecastRow(
                          day: 'Friday',
                          condition: 'Scattered Showers',
                          icon: Icons.thunderstorm_rounded,
                          iconColor: Colors.blueAccent,
                          minTemp: '23°',
                          maxTemp: '29°',
                          progress: 0.6,
                        ),
                        Divider(color: colors.outlineVariant.withAlpha(50)),
                        const _DayForecastRow(
                          day: 'Saturday',
                          condition: 'Sunny',
                          icon: Icons.wb_sunny_rounded,
                          iconColor: Colors.amber,
                          minTemp: '24°',
                          maxTemp: '32°',
                          progress: 0.75,
                        ),
                      ],
                    ),
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

// A reusable stat box widget
class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
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
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant.withAlpha(60)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withAlpha(120),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colors.primary, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: colors.outline),
          ),
        ],
      ),
    );
  }
}

// An hour forecast widget
class HourForecast extends StatelessWidget {
  const HourForecast({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  final String time;
  final IconData icon;
  final String temp;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isNow = time == 'Now';

    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: isNow ? colors.primary : colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNow ? colors.primary : colors.outlineVariant.withAlpha(60),
        ),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isNow ? colors.onPrimary : colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            size: 28,
            color: isNow ? colors.onPrimary : colors.primary,
          ),
          const SizedBox(height: 8),
          Text(
            temp,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isNow ? colors.onPrimary : colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _DayForecastRow extends StatelessWidget {
  const _DayForecastRow({
    required this.day,
    required this.condition,
    required this.icon,
    required this.iconColor,
    required this.minTemp,
    required this.maxTemp,
    required this.progress,
  });

  final String day;
  final String condition;
  final IconData icon;
  final Color iconColor;
  final String minTemp;
  final String maxTemp;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              condition,
              style: TextStyle(fontSize: 12, color: colors.outline),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(minTemp, style: TextStyle(fontSize: 12, color: colors.outline)),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
              color: colors.primary,
              backgroundColor: colors.surfaceContainerHighest,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            maxTemp,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}