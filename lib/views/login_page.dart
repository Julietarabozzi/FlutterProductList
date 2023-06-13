import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_json/viewmodels/login_viewmodel.dart';
import 'package:prueba_json/views/home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtén la instancia del modelo aquí
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFF9E007E), // This sets the AppBar color to purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // To center the items vertically
          children: <Widget>[
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50), // Give some spacing between the text and the text fields
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 50), // Add some more space before the login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9E007E), // Set the color of the button to purple
              ),
              onPressed: () {
                // Utiliza la instancia obtenida anteriormente
                loginViewModel.login(usernameController.text, passwordController.text)
                    .then((bool loginSuccessful) {
                  if (loginSuccessful) {
                    // Cambia aquí la ruta a la que quieres ir después del inicio de sesión
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    print("error al loguearse");
                  }
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
