import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    //Instancia de authService, connexion con firebase
    final authService = Provider.of<AuthService>(context, listen: false);

    final options = [
      {'title': 'Cuentas de Ahorro', 'icon': Icons.savings, 'route': 'savings'},
      {'title': 'Cuentas Corrientes', 'icon': Icons.account_balance, 'route': 'current'},
      {'title': 'Tarjetas de Crédito', 'icon': Icons.credit_card, 'route': 'credit'},
      {'title': 'Préstamos', 'icon': Icons.request_page, 'route': 'loans'},
      {'title': 'Certificados', 'icon': Icons.assignment_turned_in, 'route': 'certificates'},
      {'title': 'Mis Solicitudes', 'icon': Icons.assignment, 'route': 'requests'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          "Smart Banking",
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Seleccione el Producto de Interés",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = options[index];
                  return OptionBanking(
                    title: item['title'] as String,
                    icon: item['icon'] as IconData,
                    onTap: () {
                      final route = item['route'] as String;
                      Navigator.pushNamed(context, route);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class OptionBanking extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const OptionBanking({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

