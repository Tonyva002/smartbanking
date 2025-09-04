import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../ui/alert_dialog.dart';


class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<RequestsFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Smart Banking"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formProvider.formKey,
          child: ListView(
            children: [
              // Indicador de pasos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0 ? Colors.blue : Colors.grey[300],
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              //Titulo
              const Center(
                child: Text(
                  "Obtener información de\nTipo identificación",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Tipo de identificación
              DropdownButtonFormField<String>(
                value: formProvider.idType,
                decoration: const InputDecoration(
                  labelText: "Tipo Identificación:*",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Cédula", child: Text("Cédula")),
                  DropdownMenuItem(value: "Pasaporte", child: Text("Pasaporte")),
                  DropdownMenuItem(value: "DNI", child: Text("DNI")),
                ],
                onChanged: (value) => formProvider.setIdType(value!),
              ),
              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Captura Tipo Identificación",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Número identificación
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "No Identificación:*",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formProvider.setIdNumber(value),
                validator: (value) =>
                value == null || value.isEmpty ? "Campo obligatorio" : null,
              ),
              const SizedBox(height: 16),

              // Primer nombre
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "1er Nombre:*",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formProvider.setFirstName(value),
                validator: (value) =>
                value == null || value.isEmpty ? "Campo obligatorio" : null,
              ),
              const SizedBox(height: 16),

              // Segundo nombre
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "2do Nombre:",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formProvider.setSecondName(value),
              ),
              const SizedBox(height: 16),

              // Primer apellido
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "1er Apellido:*",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formProvider.setLastName(value),
                validator: (value) =>
                value == null || value.isEmpty ? "Campo obligatorio" : null,
              ),
              const SizedBox(height: 16),

              // Segundo apellido
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "2do Apellido:",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formProvider.setSecondLastName(value),
              ),
              const SizedBox(height: 30),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      // ... dentro del onPressed del botón Continuar
                      onPressed: () async {
                        if (formProvider.isValidForm()) {
                          final newRequest = Request(
                            createdAt: DateTime.now(),
                            firstName: formProvider.firstName,
                            secondName: formProvider.secondName,
                            lastName: formProvider.lastName,
                            secondLastName: formProvider.secondLastName,
                            idNumber: formProvider.idNumber,
                            idType: formProvider.idType,
                            status: "pending",
                          );

                          final requestsService = Provider.of<RequestsService>(context, listen: false);

                          try {
                            // Guardar en Firebase
                            await requestsService.saveRequestToFirebase(newRequest);

                            //Llamana a la funcion del dialogo
                            showRequestApprovedDialog(context, newRequest.idNumber);

                            // Limpiar formulario después de la operación exitosa
                            formProvider.clearForm();

                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Error al guardar la solicitud ❌"))
                            );
                          }
                        }
                      },
// ...

                      child: const Text("Continuar"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showRequestApprovedDialog(BuildContext context, String requestId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Pasas la función que se ejecutará al presionar "Continuar".
        return RequestApprovedDialog(
          requestId: requestId,
          onContinue: () {
            // Navegar a la pantalla de registro
            Navigator.pushNamed(context, '/register');
          },
        );
      },
    );
  }
}
