import 'dart:convert';

import 'package:flutter/services.dart';

class ParqueosDataModel {
  int? id;
  double? ancho;
  double? largo;
  String? direccion;
  String? referencias;
  double? latitud; // Cambiado de String? a double?
  double? longitud; // Cambiado de String? a double?
  int? idUsuario;

  ParqueosDataModel({
    this.id,
    this.ancho,
    this.largo,
    this.direccion,
    this.referencias,
    this.latitud,
    this.longitud,
    this.idUsuario,
  });

  factory ParqueosDataModel.fromJson(Map<String, dynamic> json) {
    return ParqueosDataModel(
      id: json['id'],
      ancho: json['ancho']?.toDouble(),
      largo: json['largo']?.toDouble(),
      direccion: json['direccion'],
      referencias: json['referencias'],
      latitud:
          json['latitud'] != null ? double.tryParse(json['latitud']) : null,
      longitud:
          json['longitud'] != null ? double.tryParse(json['longitud']) : null,
      idUsuario: json['id_usuario'],
    );
  }
}
