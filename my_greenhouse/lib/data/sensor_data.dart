class SensorData {
  final double temperatureC;
  final double temperatureF;
  final double humidity;
  final double waterLevel;
  final double soilMoisture;
  final bool fanStatus;
  final bool pumpStatus;

  SensorData({
    required this.temperatureC,
    required this.temperatureF,
    required this.humidity,
    required this.waterLevel,
    required this.soilMoisture,
    required this.fanStatus,
    required this.pumpStatus
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperatureC: json['temperatureC']?.toDouble() ?? 0.0,
      temperatureF: json['temperatureF']?.toDouble() ?? 0.0,
      humidity: json['humidity']?.toDouble() ?? 0.0,
      waterLevel: json['waterLevel']?.toDouble() ?? 0.0,
      soilMoisture: json['soilMoisture']?.toDouble() ?? 0.0,
      fanStatus: json['fanStatus'] ?? false,
      pumpStatus: json['pumpStatus'] ?? false,
    );
  }
}