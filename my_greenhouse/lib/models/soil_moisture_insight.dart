import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/data/firebase_service.dart';
import 'package:my_greenhouse/data/sensor_data.dart';

class SoilMoistureInsight extends StatefulWidget {
  const SoilMoistureInsight({super.key});

  @override
  State<SoilMoistureInsight> createState() => _SoilMoistureInsightState();
}

class _SoilMoistureInsightState extends State<SoilMoistureInsight> {
  final FirebaseService firebaseService = FirebaseService();
  final int maxDataPoints = 60;
  TimeUnit selectedTimeUnit = TimeUnit.minute;

  @override
  void initState() {
    super.initState();
    // If the data is empty, initialize it
    if (firebaseService.soilMoistureDataPoints[TimeUnit.second]!.isEmpty) {
      for (var unit in TimeUnit.values) {
        firebaseService.soilMoistureDataPoints[unit] = [];
        firebaseService.lastUpdateTime[unit] = DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soil Moisture',
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
          ),
          body: StreamBuilder<SensorData?>(
            stream: firebaseService.sensorDataStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No data available'));
              } else {
                final sensorData = snapshot.data!;
                updateDataPoints(sensorData);
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: Constants.verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 2))
                          ],
                          border: Border.all(
                              color: sensorData.soilMoisture < 30
                                  ? Colors.red.shade400
                                  : Colors.green.shade400,
                              width: 3),
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.5),
                              child: Text(
                                'Status: ${sensorData.soilMoisture < 30 ? 'Low' : (sensorData.soilMoisture > 70 ? 'High' : 'Normal')}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: sensorData.soilMoisture < 30
                                      ? Colors.red.shade400
                                      : Colors.green.shade400,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 2))
                          ],
                          border: Border.all(
                              color: sensorData.soilMoisture < 30
                                  ? Colors.red.shade400
                                  : Colors.green.shade400,
                              width: 3),
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.5),
                              child: Text(
                                'Soil Moisture : ${sensorData.soilMoisture}% ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: sensorData.soilMoisture < 30
                                      ? Colors.red.shade400
                                      : Colors.green.shade400,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildChartContainer(sensorData),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChartContainer(SensorData sensorData) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Soil Moisture Trend',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Constants.primaryColor,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton<TimeUnit>(
                    value: selectedTimeUnit,
                    onChanged: (TimeUnit? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedTimeUnit = newValue;
                        });
                      }
                    },
                    items: TimeUnit.values.map((TimeUnit unit) {
                      return DropdownMenuItem<TimeUnit>(
                        value: unit,
                        child: Text(
                          unit.toString().split('.').last,
                          style: TextStyle(color: Constants.primaryColor),
                        ),
                      );
                    }).toList(),
                    underline: Container(),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Constants.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  minX: 0,
                  maxX: (maxDataPoints - 1).toDouble(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: firebaseService
                          .soilMoistureDataPoints[selectedTimeUnit]!,
                      isCurved: true,
                      color: Constants.primaryColor1,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          if (index ==
                              firebaseService
                                      .soilMoistureDataPoints[selectedTimeUnit]!
                                      .length -
                                  1) {
                            return FlDotCirclePainter(
                              radius: 6,
                              color: Colors.white,
                              strokeWidth: 3,
                              strokeColor: Constants.primaryColor1,
                            );
                          }
                          return FlDotCirclePainter(
                            radius: 0,
                            color: Colors.transparent,
                            strokeWidth: 0,
                            strokeColor: Colors.transparent,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Constants.primaryColor1.withOpacity(0.1),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            getXAxisLabel(value),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                        interval: maxDataPoints / 6,
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        interval: 10,
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[300],
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                      left: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateDataPoints(SensorData newData) {
    final now = DateTime.now();
    for (var unit in TimeUnit.values) {
      if (shouldUpdateUnit(unit, now)) {
        if (firebaseService.soilMoistureDataPoints[unit]!.length >=
            maxDataPoints) {
          firebaseService.soilMoistureDataPoints[unit]!.removeAt(0);
          for (int i = 0;
              i < firebaseService.soilMoistureDataPoints[unit]!.length;
              i++) {
            firebaseService.soilMoistureDataPoints[unit]![i] = FlSpot(
                i.toDouble(),
                firebaseService.soilMoistureDataPoints[unit]![i].y);
          }
        }
        firebaseService.soilMoistureDataPoints[unit]!.add(FlSpot(
            firebaseService.soilMoistureDataPoints[unit]!.length.toDouble(),
            newData.soilMoisture));
        firebaseService.lastUpdateTime[unit] = now;
      }
    }
    aggregateDataPoints();
  }

  bool shouldUpdateUnit(TimeUnit unit, DateTime now) {
    final lastUpdate = firebaseService.lastUpdateTime[unit]!;
    switch (unit) {
      case TimeUnit.second:
        return true;
      case TimeUnit.minute:
        return now.difference(lastUpdate).inMinutes > 0;
      case TimeUnit.hour:
        return now.difference(lastUpdate).inHours > 0;
      case TimeUnit.day:
        return now.difference(lastUpdate).inDays > 0;
      case TimeUnit.week:
        return now.difference(lastUpdate).inDays >= 7;
    }
  }

  void aggregateDataPoints() {
    for (var unit in TimeUnit.values) {
      if (unit == TimeUnit.second) continue;

      final lowerUnit = TimeUnit.values[TimeUnit.values.indexOf(unit) - 1];
      final lowerUnitData = firebaseService.soilMoistureDataPoints[lowerUnit]!;

      if (lowerUnitData.isEmpty) continue;

      final aggregatedData = <FlSpot>[];
      double sum = 0;
      int count = 0;

      for (int i = 0; i < lowerUnitData.length; i++) {
        sum += lowerUnitData[i].y;
        count++;

        if ((i + 1) % getAggregationFactor(unit) == 0 ||
            i == lowerUnitData.length - 1) {
          aggregatedData
              .add(FlSpot(aggregatedData.length.toDouble(), sum / count));
          sum = 0;
          count = 0;
        }
      }

      firebaseService.soilMoistureDataPoints[unit] = aggregatedData;
    }
  }

  int getAggregationFactor(TimeUnit unit) {
    switch (unit) {
      case TimeUnit.minute:
        return 60;
      case TimeUnit.hour:
        return 60;
      case TimeUnit.day:
        return 24;
      case TimeUnit.week:
        return 7;
      default:
        return 1;
    }
  }

  String getXAxisLabel(double value) {
    final int index = value.toInt();
    final now = DateTime.now();

    switch (selectedTimeUnit) {
      case TimeUnit.second:
        return '${index + 1}s';
      case TimeUnit.minute:
        return '${index + 1}m';
      case TimeUnit.hour:
        return '${index + 1}h';
      case TimeUnit.day:
        return '${index + 1}d';
      case TimeUnit.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final weekDate = startOfWeek.add(Duration(days: 7 * index));
        return 'W${weekDate.weekOfYear}';
    }
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfYear {
    final firstJan = DateTime(year, 1, 1);
    final daysOffset = (7 - firstJan.weekday + 1) % 7;
    final firstMonday = firstJan.add(Duration(days: daysOffset));
    final diff = difference(firstMonday);
    final weeks = (diff.inDays / 7).floor();
    return weeks + 1;
  }
}
