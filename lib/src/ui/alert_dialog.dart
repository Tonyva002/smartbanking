import 'package:flutter/material.dart';

class RequestApprovedDialog extends StatelessWidget {
  final String requestId;
  final VoidCallback onContinue; // Declaración de la función

  const RequestApprovedDialog({
    super.key,
    required this.requestId,
    required this.onContinue, // El constructor ahora requiere esta función
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
          const SizedBox(height: 16),
          Text(
            '¡Su solicitud $requestId fue aprobada!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Presionando el botón continuar podrá registrar su usuario y contraseña.\n\nLe enviaremos un correo con más detalle de la solicitud de su Tarjeta de Crédito Visa Gold y los próximos pasos.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Registrarme Luego'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
            onContinue(); // Llama a la función pasada por el constructor
          },
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}