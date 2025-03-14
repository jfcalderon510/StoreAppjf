import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [HeaderSignUpWidget(), BodySignUpWidget()]),
    );
  }
}

class BodySignUpWidget extends StatefulWidget {
  const BodySignUpWidget({super.key});

  @override
  State<BodySignUpWidget> createState() => _BodySignUpWidgetState();
}

class _BodySignUpWidgetState extends State<BodySignUpWidget> {
  bool showPasswordSignup = false;
  bool showPasswordSingupconfirm = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80, bottom: 10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/474x/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.jpg",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nombre",
                  hintText: "Escriba su Nombre",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Documento",
                  hintText: "Escriba su Identificación",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Escriba su Correo",
                ),
              ),
              TextField(
                obscureText: !showPasswordSignup,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Escriba su contraseña",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPasswordSignup = true; // Mostrar la contraseña
                      });

                      // Ocultar la contraseña después de 2 segundos automáticamente
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          showPasswordSignup = false;
                        });
                      });
                    },
                    child: Icon(
                      showPasswordSignup
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              TextField(
                obscureText: !showPasswordSingupconfirm,
                decoration: InputDecoration(
                  labelText: "Confirmar Contraseña",
                  hintText: "Escriba de nuevo la Contraseña",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPasswordSingupconfirm = true; // Mostrar la contraseña
                      });

                      // Ocultar la contraseña después de 2 segundos automáticamente
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          showPasswordSingupconfirm = false;
                        });
                      });
                    },
                    child: Icon(
                      showPasswordSingupconfirm
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceEvenly, // Distribuye el espacio uniformemente
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      child: Text("Regresar", textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(width: 16), // Espacio entre botones
                  Expanded(
                    child: FilledButton(
                      onPressed: () => {},
                      child: Text("Crear Usuario", textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSignUpWidget extends StatelessWidget {
  const HeaderSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.blue,
                width: double.infinity,
                child: Text(
                  "Crear usuario",
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
