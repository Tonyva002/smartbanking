import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final creditCardsService = Provider.of<CreditCardsService>(context);

    if (creditCardsService.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (creditCardsService.cards.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No hay tarjetas disponibles")),
      );
    }

    final card = creditCardsService.cards.first;

    final clasica = creditCardsService.getClasica(card);
    final platinum = creditCardsService.getPlatinum(card);
    final infinite = creditCardsService.getInfinite(card);

    final costos = creditCardsService.getCardCosts(card);
    final beneficios = creditCardsService.getCardBenefits(card);
    final requisitos = creditCardsService.getCardRequirements(card);

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
            CreditCardImage(picture: card.imagenUrl),

            const SizedBox(height: 20),

            // Costos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CostItem(
                  title: "Costo Emisión",
                  value: "RD\$${costos.emision.toString()}",
                  icon: Icons.attach_money,
                ),
                CostItem(
                  title: "Plástico Adicional",
                  value: "RD\$${costos.plasticoAdicional.toString()}",
                  icon: Icons.credit_card,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Beneficios y Requisitos
            InfoCarousel(beneficios: beneficios, requisitos: requisitos),

            const SizedBox(height: 20),

            // Productos relacionados
            Align(
              alignment: Alignment.center,
              child: Text(
                "Productos relacionados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RelatedProduct(
                  title: clasica.nombre,
                  picture: clasica.imagenUrl,
                ),
                RelatedProduct(
                  title: platinum.nombre,
                  picture: platinum.imagenUrl,
                ),
                RelatedProduct(
                  title: infinite.nombre,
                  picture: infinite.imagenUrl,
                ),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
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

  const CostItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

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

class RelatedProduct extends StatelessWidget {
  final String title;
  final String picture;

  const RelatedProduct({super.key, required this.title, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RelatedProductsImage(picture: picture),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}
