import 'dart:convert';

import 'package:flutter/services.dart';

class ParqueosDataModel {
  int? id;
  double? ancho;
  double? largo;
  String? direccion;
  String? referencias;
  String? latitud;
  String? longitud;
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
      ancho: json['ancho']
          ?.toDouble(), // Convertir a double ya que el JSON puede contener enteros o números decimales
      largo: json['largo']?.toDouble(),
      direccion: json['direccion'],
      referencias: json['referencias'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      idUsuario: json['id_usuario'],
    );
  }
}
