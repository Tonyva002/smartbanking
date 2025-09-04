
import 'dart:convert';

CreditCard creditCardFromJson(String str) => CreditCard.fromJson(json.decode(str));

String creditCardToJson(CreditCard data) => json.encode(data.toJson());

class CreditCard {
  List<Document> documents;

  CreditCard({
    required this.documents,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
    documents: List<Document>.from(json["documentos"].map((x) => Document.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "documentos": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class Document {
  List<String> beneficios;
  List<String> requisitos;
  Costos costos;
  String id;
  String imagenUrl;
  String nombre;
  List<Relacionado> relacionados;

  Document({
    required this.beneficios,
    required this.requisitos,
    required this.costos,
    required this.id,
    required this.imagenUrl,
    required this.nombre,
    required this.relacionados,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    beneficios: List<String>.from(json["beneficios"].map((x) => x)),
    requisitos: List<String>.from(json["requisitos"].map((x) => x)),
    costos: Costos.fromJson(json["costos"]),
    id: json["id"],
    imagenUrl: json["imagen_url"],
    nombre: json["nombre"],
    relacionados: List<Relacionado>.from(json["relacionados"].map((x) => Relacionado.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "beneficios": List<dynamic>.from(beneficios.map((x) => x)),
    "requisitos": List<dynamic>.from(requisitos.map((x) => x)),
    "costos": costos.toJson(),
    "id": id,
    "imagen_url": imagenUrl,
    "nombre": nombre,
    "relacionados": List<dynamic>.from(relacionados.map((x) => x.toJson())),
  };
}

class Costos {
  int emision;
  int plasticoAdicional;

  Costos({
    required this.emision,
    required this.plasticoAdicional,
  });

  factory Costos.fromJson(Map<String, dynamic> json) => Costos(
    emision: json["emision"],
    plasticoAdicional: json["plastico_adicional"],
  );

  Map<String, dynamic> toJson() => {
    "emision": emision,
    "plastico_adicional": plasticoAdicional,
  };
}

class Relacionado {
  String id;
  String imagenUrl;
  String nombre;

  Relacionado({
    required this.id,
    required this.imagenUrl,
    required this.nombre,
  });

  factory Relacionado.fromJson(Map<String, dynamic> json) => Relacionado(
    id: json["id"],
    imagenUrl: json["imagen_url"],
    nombre: json["nombre"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imagen_url": imagenUrl,
    "nombre": nombre,
  };
}
