class VehiculosDataModel {
  final String matricula;
  final String color;
  final double altura;
  final double ancho;
  final double largo;
  final String modelo;

  VehiculosDataModel({
    required this.matricula,
    required this.color,
    required this.altura,
    required this.ancho,
    required this.largo,
    required this.modelo,
  });

  factory VehiculosDataModel.fromJson(Map<String, dynamic> json) {
    return VehiculosDataModel(
      matricula: json['matricula'] ?? '',
      color: json['color'] ?? '',
      altura: (json['altura'] ?? 0.0).toDouble(),
      ancho: (json['ancho'] ?? 0.0).toDouble(),
      largo: (json['largo'] ?? 0.0).toDouble(),
      modelo: json['modelo'] ?? '',
    );
  }
}
