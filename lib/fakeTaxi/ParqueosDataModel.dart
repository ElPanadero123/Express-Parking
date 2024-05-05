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
      idSeccion: json['idSeccion'],
      imagenSeccion: json['imagenSeccion'],
      ancho: (json['ancho'] as num).toDouble(),
      largo: (json['largo'] as num).toDouble(),
      horaInicio: json['horaInicio'],
      horaFinal: json['horaFinal'],
      estado: json['estado'],
      altura: (json['altura'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idSeccion': idSeccion,
      'imagenSeccion': imagenSeccion,
      'ancho': ancho,
      'largo': largo,
      'horaInicio': horaInicio,
      'horaFinal': horaFinal,
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
    var seccionesJson = json['secciones'] as List<dynamic>;
    List<Seccion> seccionesList = seccionesJson
        .map((s) => Seccion.fromJson(s as Map<String, dynamic>))
        .toList();

    return Garaje(
      id: json['id'],
      nombre: json['nombre'],
      imagenGaraje: json['imagenGaraje'],
      ancho: (json['ancho'] as num).toDouble(),
      largo: (json['largo'] as num).toDouble(),
      direccion: json['direccion'],
      notas: json['notas'],
      referencias: json['referencias'],
      latitud:
          json['latitud'] != null ? double.tryParse(json['latitud']) : null,
      longitud:
          json['longitud'] != null ? double.tryParse(json['longitud']) : null,
      secciones: seccionesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'imagenGaraje': imagenGaraje,
      'ancho': ancho,
      'largo': largo,
      'direccion': direccion,
      'notas': notas,
      'referencias': referencias,
      'latitud': latitud,
      'longitud': longitud,
      'secciones': secciones
    };
  }
}
