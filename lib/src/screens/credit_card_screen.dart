import 'package:flutter/material.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Banking"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Tarjeta de Crédito Visa Gold",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Imagen de la tarjeta
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://via.placeholder.com/300x180.png?text=Visa+Gold",
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Costos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CostItem(
                    title: "Costo Emisión", value: "RD\$5,000.00", icon: Icons.attach_money),
                CostItem(
                    title: "Plástico Adicional", value: "RD\$5,000.00", icon: Icons.credit_card),
              ],
            ),
            const SizedBox(height: 20),

            // Beneficios
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Beneficios",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            const BenefitList(),

            const SizedBox(height: 20),

            // Productos relacionados
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Productos relacionados",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                RelatedProduct(title: "Visa Clásica"),
                RelatedProduct(title: "Visa Platinum"),
                RelatedProduct(title: "Visa Infinite"),
              ],
            ),
            const SizedBox(height: 30),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Realizar Solicitud"),
                  style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                  style: OutlinedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CostItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const CostItem({Key? key, required this.title, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 5),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}

class BenefitList extends StatelessWidget {
  const BenefitList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beneficios = [
      "80% del límite disponible para retiro en efectivo.",
      "Programa de doble acumulación Puntos.",
      "Plan de financiamiento.",
      "Seguros opcionales.",
      "Cuenta Protegida.",
      "Seguro de Accidentes de Viaje."
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: beneficios
          .map((b) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            const Icon(Icons.check, size: 16, color: Colors.blue),
            const SizedBox(width: 5),
            Expanded(child: Text(b)),
          ],
        ),
      ))
          .toList(),
    );
  }
}

class RelatedProduct extends StatelessWidget {
  final String title;
  const RelatedProduct({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          child: Container(
            width: 80,
            height: 50,
            color: Colors.grey.shade300,
            child: const Icon(Icons.credit_card),
          ),
        ),
        const SizedBox(height: 5),
        Text(title)
      ],
    );
  }
}
