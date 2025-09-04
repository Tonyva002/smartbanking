import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class CreditCardsService extends ChangeNotifier {
  final String _baseUrl = 'smartbanking-66658-default-rtdb.firebaseio.com';
  List<Document> cards = [];
  bool isLoading = true;

  CreditCardsService() {
    fetchCards();
  }

  Future<void> fetchCards() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'tarjetas_credito.json');
    final response = await http.get(url);

    print("Respuesta Firebase: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // ✅ Ahora buscamos la clave "documentos", que es la correcta
      if (data.containsKey("documentos") && data["documentos"] != null) {
        cards = (data["documentos"] as List)
            .map((x) => Document.fromJson(x))
            .toList();
      } else {
        cards = [];
      }
    } else {
      cards = [];
    }

    isLoading = false;
    notifyListeners();
  }

  // Métodos para obtener relacionados por tipo
  Relacionado getClasica(Document card) {
    return card.relacionados.firstWhere(
          (r) => r.id.toLowerCase().contains("clasica"),
      orElse: () => Relacionado(id: "", imagenUrl: "", nombre: "N/A"),
    );
  }

  Relacionado getPlatinum(Document card) {
    return card.relacionados.firstWhere(
          (r) => r.id.toLowerCase().contains("platinum"),
      orElse: () => Relacionado(id: "", imagenUrl: "", nombre: "N/A"),
    );
  }

  Relacionado getInfinite(Document card) {
    return card.relacionados.firstWhere(
          (r) => r.id.toLowerCase().contains("infinite"),
      orElse: () => Relacionado(id: "", imagenUrl: "", nombre: "N/A"),
    );
  }

  // Metodo para obtener los costos de una tarjeta
  Costos getCardCosts(Document card) {
    return card.costos;
  }


  // Metodo para obtener los beneficios de una tarjeta
  List<String> getCardBenefits(Document card) {
    return card.beneficios;
  }


  List<String> getCardRequirements(Document card) {
    return card.requisitos;
  }

}
