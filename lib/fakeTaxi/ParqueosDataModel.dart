class Seccion {
  final int idSeccion;
  final String imagenSeccion;
  final double ancho;
  final double largo;
  final String horaInicio;
  final String horaFinal;
  final String estado;
  final double altura;

  Seccion({
    required this.idSeccion,
    required this.imagenSeccion,
    required this.ancho,
    required this.largo,
    required this.horaInicio,
    required this.horaFinal,
    required this.estado,
    required this.altura,
  });

  factory Seccion.fromJson(Map<String, dynamic> json) {
    return Seccion(
      idSeccion:
          json['id_seccion'] ?? 0, // Valor por defecto en caso de que sea null
      imagenSeccion: json['imagen_seccion'] ?? '',
      ancho: (json['ancho'] ?? 0).toDouble(),
      largo: (json['largo'] ?? 0).toDouble(),
      horaInicio: json['hora_inicio'] ?? '',
      horaFinal: json['hora_final'] ?? '',
      estado: json['estado'] ?? '',
      altura: (json['altura'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_seccion': idSeccion,
      'imagen_seccion': imagenSeccion,
      'ancho': ancho,
      'largo': largo,
      'hora_inicio': horaInicio,
      'hora_final': horaFinal,
      'estado': estado,
      'altura': altura,
    };
  }
}

class Garaje {
  final int id;
  final String nombre;
  final String imagenGaraje;
  final double ancho;
  final double largo;
  final String direccion;
  final String notas;
  final String referencias;
  final double? latitud;
  final double? longitud;
  final List<Seccion> secciones;

  Garaje({
    required this.id,
    required this.nombre,
    required this.imagenGaraje,
    required this.ancho,
    required this.largo,
    required this.direccion,
    required this.notas,
    required this.referencias,
    this.latitud,
    this.longitud,
    required this.secciones,
  });

  factory Garaje.fromJson(Map<String, dynamic> json) {
    var seccionesJson = json['secciones'] as List<dynamic>? ?? [];
    List<Seccion> seccionesList = seccionesJson
        .map((s) => Seccion.fromJson(s as Map<String, dynamic>))
        .toList();

    return Garaje(
      id: json['id_garaje'] ?? 0,
      nombre: 'Garaje ' +
          (json['id_garaje'] != null ? json['id_garaje'].toString() : ''),
      imagenGaraje: json['imagen_garaje'] ?? '',
      ancho: (json['ancho'] ?? 0).toDouble(),
      largo: (json['largo'] ?? 0).toDouble(),
      direccion: json['direccion'] ?? '',
      notas: json['notas'] ?? '',
      referencias: json['referencias'] ?? '',
      latitud: json['latitud'] != null
          ? double.tryParse(json['latitud'].toString())
          : null,
      longitud: json['longitud'] != null
          ? double.tryParse(json['longitud'].toString())
          : null,
      secciones: seccionesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_garaje': id,
      'nombre': nombre,
      'imagen_garaje': imagenGaraje,
      'ancho': ancho,
      'largo': largo,
      'direccion': direccion,
      'notas': notas,
      'referencias': referencias,
      'latitud': latitud,
      'longitud': longitud,
      'secciones': secciones.map((s) => s.toJson()).toList(),
    };
  }
}
