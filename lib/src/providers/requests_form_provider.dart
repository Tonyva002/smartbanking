import 'package:flutter/material.dart';

class RequestsFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Campos del formulario
  String idType = 'Cédula';
  String idNumber = '';
  String firstName = '';
  String secondName = '';
  String lastName = '';
  String secondLastName = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Validar formulario
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Métodos para actualizar campos
  void setIdType(String value) {
    idType = value;
    notifyListeners();
  }

  void setIdNumber(String value) {
    idNumber = value;
    notifyListeners();
  }

  void setFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void setSecondName(String value) {
    secondName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void setSecondLastName(String value) {
    secondLastName = value;
    notifyListeners();
  }

  void clearForm() {
    firstName = '';
    secondName = '';
    lastName = '';
    secondLastName = '';
    idNumber = '';
    formKey.currentState?.reset();
    notifyListeners();
  }

}
