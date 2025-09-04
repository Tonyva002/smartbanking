
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbanking/src/services/services.dart';
import 'package:smartbanking/src/theme/theme.dart';

import 'src/providers/providers.dart';
import 'src/router/routes.dart';

void main(){
  runApp(const AppState());
}


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //Estado global, conexion con firebase
          ChangeNotifierProvider(create: ( _ ) => AuthService()),
          ChangeNotifierProvider(create: ( _ ) => CreditCardsService()),
          ChangeNotifierProvider(create: ( _ ) => RequestsService()),
          ChangeNotifierProvider(create: ( _ ) => RequestsFormProvider())
        ],
      child: const MyApp()
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      title: "Smart Banking",
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.lightTheme,

    );
  }
}
