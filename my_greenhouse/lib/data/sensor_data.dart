class SensorData {
  final double temperature;
  final double humidity;
  final double soilMoisture;
  final double waterLevel;

  SensorData({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.waterLevel,
  });

  factory SensorData.fromJson(dynamic json) {
    return SensorData(
      temperature: double.tryParse(json['field1']) ?? 0.0,
      humidity: double.tryParse(json['field2']) ?? 0.0,
      soilMoisture: double.tryParse(json['field3']) ?? 0.0,
      waterLevel: double.tryParse(json['field4']) ?? 0.0,
    );
  }
}
