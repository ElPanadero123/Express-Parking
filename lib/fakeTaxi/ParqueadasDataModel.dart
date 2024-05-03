class ParqueadasDataModel {
  final String horaInicio;
  final String horaFin;
  final double precio;

  ParqueadasDataModel({
    required this.horaInicio,
    required this.horaFin,
    required this.precio,
  });

  factory ParqueadasDataModel.fromJson(Map<String, dynamic> json) {
    return ParqueadasDataModel(
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
      precio: json['precio'].toDouble(),
    );
  }
}
