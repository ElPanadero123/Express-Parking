class OfertasDataModel {
  final String direccion;
  final String horaInicio;
  final String horaFinal;
  final double precioEstimado;
  final String fecha;
  final String estado;

  OfertasDataModel({
    required this.direccion,
    required this.horaInicio,
    required this.horaFinal,
    required this.precioEstimado,
    required this.fecha,
    required this.estado,
  });

  factory OfertasDataModel.fromJson(Map<String, dynamic> json) {
    return OfertasDataModel(
      direccion: json['direccion'],
      horaInicio: json['hora_inicio'],
      horaFinal: json['hora_final'],
      precioEstimado: json['precio_estimado'],
      fecha: json['fecha'],
      estado: json['estado'],
    );
  }
}