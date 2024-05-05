class Garaje {
  final int id;
  final String imagenGaraje;
  final double ancho;
  final double largo;
  final String direccion;
  final String notas;
  final String referencias;
  final double? latitud;
  final double? longitud;
  final int idUsuario;

  Garaje({
    required this.id,
    required this.imagenGaraje,
    required this.ancho,
    required this.largo,
    required this.direccion,
    required this.notas,
    required this.referencias,
    this.latitud,
    this.longitud,
    required this.idUsuario,
  });

  factory Garaje.fromJson(Map<String, dynamic> json) {
    return Garaje(
      id: json['id_garaje'] as int,
      imagenGaraje: json['imagen_garaje'] as String,
      ancho: (json['ancho'] as num).toDouble(),
      largo: (json['largo'] as num).toDouble(),
      direccion: json['direccion'] as String,
      notas: json['notas'] as String,
      referencias: json['referencias'] as String,
      latitud: (json['latitud'] as num?)?.toDouble(),
      longitud: (json['longitud'] as num?)?.toDouble(),
      idUsuario: json['id_usuario'] as int,
    );
  }
}
