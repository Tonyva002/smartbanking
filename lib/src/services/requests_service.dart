import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';


class RequestsService extends ChangeNotifier {
  final String _baseUrl = 'smartbanking-66658-default-rtdb.firebaseio.com';
  List<Request> requests = [];
  bool isLoading = true;

  RequestsService() {
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'requests.json');
    final response = await http.get(url);


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      requests = data.entries
          .map((entry) => Request.fromJson(entry.value))
          .toList();
        } else {
      requests = [];
    }

    isLoading = false;
    notifyListeners();
  }

  // Metodo para filtrar solicitudes por estado
  List<Request> getByStatus(String status) {
    return requests.where((r) => r.status.toLowerCase() == status.toLowerCase()).toList();
  }

  // Metodo para buscar una solicitud por cédula o ID
  Request? getByIdNumber(String idNumber) {
    try {
      return requests.firstWhere((r) => r.idNumber == idNumber);
    } catch (e) {
      return null;
    }
  }

  // Metodo para agregar la informacion a firebase
  Future<void> saveRequestToFirebase(Request request) async {
    final url = Uri.https(_baseUrl, 'requests.json'); // "requests.json" es la colección en Firebase

    final response = await http.post(
      url,
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      // ✅ Opcional: agregar a la lista local después de guardar en Firebase
      requests.add(request);
      notifyListeners();
    } else {
      throw Exception('Error al guardar la solicitud en Firebase');
    }
  }


  // Metodo para actualizar el estado de una solicitud
  void updateStatus(String idNumber, String newStatus) {
    final request = getByIdNumber(idNumber);
    if (request != null) {
      request.status = newStatus;
      notifyListeners();
    }
  }
}
