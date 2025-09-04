import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/screens.dart';



class AppRoutes {
  // ruta iniciar
  static const initialRoute = "checking";

  // rota para navegar
  static final menuOptions = <MenuOption>[
    MenuOption(route: "checking", name: "Check auth", screen: CheckAuthScreen(), icon: Icons.home_sharp),
    MenuOption(route: "login", name: "Login", screen: const LoginScreen(), icon: Icons.supervised_user_circle_outlined),
    MenuOption(route: "register", name: "Register", screen: const RegisterScreen(), icon: Icons.app_registration_outlined),
    MenuOption(route: "home", name: "Home", screen: const HomeScreen(), icon: Icons.home_sharp),
    MenuOption(route: "savings", name: "Savings account", screen: const SavingAccountsScreen(), icon: Icons.home_sharp),
    MenuOption(route: "current", name: "Current account", screen: const CurrentAccountsScreen(), icon: Icons.home_sharp),
    MenuOption(route: "credit", name: "Credit card", screen: const CreditCardScreen(), icon: Icons.account_balance_sharp),
    MenuOption(route: "loans", name: "Loans", screen: const LoansScreen(), icon: Icons.account_balance_sharp),
    MenuOption(route: "certificates", name: "Certificates", screen: const CertificatesScreen(), icon: Icons.home_sharp),
    MenuOption(route: "requests", name: "Requests", screen: const RequestsScreen(), icon: Icons.home_sharp),



  ];


  static Map<String, Widget Function(BuildContext)> getAppRoutes(){

    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'login' : (BuildContext context) => const LoginScreen()});

    for(final option in menuOptions){
      appRoutes.addAll({option.route : (BuildContext context) => option.screen} );
    }
    return appRoutes;

  }
}