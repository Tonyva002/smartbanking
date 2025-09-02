import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../services/services.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),  // Llamada al formulario
                  ),
                ],
              ),
            ),

            // Espacio entre los componentes
            const SizedBox(height: 50),

            // Para crear una nueva cuenta navegar a a la pantalla de registro
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.indigo.withValues(alpha: 0.1)),
                shape: WidgetStatePropertyAll(const StadiumBorder()),
              ),
              child: const Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}

//Clase privada para el formulario
class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //Componente del correo del usuario
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 't...do@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Agregue un correo valido';
            },
          ),

          // Espacio entre los componentes
          const SizedBox(height: 30),

          //Componente de la contraseña del usuario
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: '***....',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe ser de 6 o mas caracteres';
            },
          ),

          // Espacio entre los componentes
          const SizedBox(height: 30),

          // Si el usuario y contraseña es correcto ir a la pantalla de home, de lo contrario mostrar mensaje Usuario y contraseña invalida
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      //Instancia de authService, connexion con firebase
                      final authService = Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      //validar si el login es correcto
                      final String? response = await authService.login(loginForm.email, loginForm.password);

                      if(response == null){
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        //Llamada a metodo para agregar mensaje en la aplicacion
                        NotificationsService.showSnackbar('Usuario y contraseña invalida');
                        loginForm.isLoading = false;
                      }

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
