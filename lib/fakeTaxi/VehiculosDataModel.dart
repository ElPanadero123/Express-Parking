class VehiculosDataModel {
  final int id;
  final String marca;
  final String matricula;
  final String color;
  final double altura;
  final double ancho;
  final double largo;
  final String modelo;

  VehiculosDataModel({
    required this.marca,
    required this.id,
    required this.matricula,
    required this.color,
    required this.altura,
    required this.ancho,
    required this.largo,
    required this.modelo,
  });

  factory VehiculosDataModel.fromJson(Map<String, dynamic> json) {
    return VehiculosDataModel(
      id: json['id_vehiculo'],
      marca: json['marca'],
      matricula: json['matricula'] ?? '',
      color: json['color'] ?? '',
      altura: json['altura'] != null
          ? double.parse(json['altura'].toString())
          : 0.0,
      ancho:
          json['ancho'] != null ? double.parse(json['ancho'].toString()) : 0.0,
      largo:
          json['largo'] != null ? double.parse(json['largo'].toString()) : 0.0,
      modelo: json['Modelo'] ?? '',
    );
  }
}
