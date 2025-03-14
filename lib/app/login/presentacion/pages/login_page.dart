import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeappv2/app/di/dependency_injection.dart';
import 'package:storeappv2/app/login/presentacion/bloc/login_bloc.dart';
import 'package:storeappv2/app/login/presentacion/bloc/login_event.dart';
import 'package:storeappv2/app/login/presentacion/bloc/login_state.dart';
import 'package:storeappv2/app/login/presentacion/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependecyInjection.serviceLocator.get<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            HeaderLoginWidget(),
            BodyLoginWidget(),
            FooterLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aun no tienes cuenta?"),
                    SizedBox(width: 32.0),
                    GestureDetector(
                      onTap: () => {GoRouter.of(context).pushNamed("sign-up")},
                      child: Text(
                        "Registrate Aca",
                        style: TextStyle(
                          color: Colors.purple,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                width: double.infinity,
                height: 100,
                fit: BoxFit.fitWidth,
                "https://community.listopro.com/content/images/2023/05/-----LISTOPRO-BLOG---Tokens-de-disen-o-en-Flutter.png",
              ),
              Container(
                color: Colors.blue,
                width: double.infinity,
                child: Text(
                  "Inicio de Sesion",
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

class BodyLoginWidget extends StatefulWidget {
  BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();
  //String _email = "";
  //String _password = ""; //quitar cuando se trabaje con block

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;

          case LoginSuccessState():
            GoRouter.of(context).pushReplacementNamed("home");
            break;

          case LoginErrorState():
            showDialog(context: context, builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: Text(state.message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));

            break;
          default:
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm =
              validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null;       

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: 32.0,
                left: 32.0,
                top: 80,
                bottom: 10,
              ),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged:
                          (value) => setState(() {
                            bloc.add(EmailChangeEvent(email: value));
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmail,
                      //initialValue: "juan@correo.com",
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.person),
                        hintText: "Escriba su Usuario",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      onChanged:
                          (value) => setState(() {
                            bloc.add(PasswordChangeEvent(password: value));
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validatePassword,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Escriba su Contraseña",
                        suffixIcon: InkWell(
                          onTap: () {
                            _autoShowTimer?.cancel();
                            if (!_showPassword) {
                              _autoShowTimer = Timer(
                                Duration(seconds: 3),
                                () => setState(() {
                                  _showPassword = false;
                                }),
                              );
                            }
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    FilledButton(
                      onPressed:
                          isValidForm
                              ? () => {bloc.add(SubmitEvent())}
                              : null, //hacer la logica
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Iniciar Sesión",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
