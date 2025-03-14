//import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeappv2/app/di/dependency_injection.dart';
import 'package:storeappv2/app/sing_up/presentacion/bloc/form_sing_up_bloc.dart';
import 'package:storeappv2/app/sing_up/presentacion/bloc/form_sing_up_event.dart';
import 'package:storeappv2/app/sing_up/presentacion/bloc/form_sing_up_state.dart';
import 'package:storeappv2/app/sing_up/presentacion/pages/sign_up_mixin.dart';

class SingUpPage extends StatelessWidget {
  final String? id;
  const SingUpPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependecyInjection.serviceLocator.get<FormSingUpBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          title: Text(id == null ? "Agregar Nuevo Usuario" : "Actualizar"),
        ),
        body: Column(children: [BodySignUpWidget(id)]),
      ),
    );
  }
}

class BodySignUpWidget extends StatefulWidget {
  const BodySignUpWidget(this.id, {super.key});
  final String? id;
  @override
  State<BodySignUpWidget> createState() => _BodySignUpWidgetState();
}

class _BodySignUpWidgetState extends State<BodySignUpWidget> with SignUpMixin {
  bool _showPasswordSignUp = false;
  Timer? _autoShowTimerSignUp;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormSingUpBloc>();
    if (widget.id != null) {
      bloc.add(GetUserEvent(widget.id!));
    }
    //TextEditingController nameField = TextEditingController();
    //TextEditingController priceField = TextEditingController();
    //TextEditingController urlField = TextEditingController();

    return BlocListener<FormSingUpBloc, FormSingUpState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
            break;
        }
      },
      child: BlocBuilder<FormSingUpBloc, FormSingUpState>(
        builder: (context, state) {
          //nameField.text = state.model.name;
          //priceField.text = state.model.price;
          //urlField.text = state.model.urlImage;

          final bool isValidForm =
              validateEmail(state.model.user) == null &&
              validatePassword(state.model.password) == null;

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    //Text(state.model.name),
                    TextFormField(
                      //controller: nameField,
                      onChanged:
                          (value) => bloc.add(NameChangeEvent(name: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Name:",
                        icon: Icon(Icons.person),
                        hintText: "Escribe el nombre del Usuario",
                      ),
                      // keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      // controller:urlField,
                      onChanged:
                          (value) =>
                              bloc.add(DocumentChangeEvent(document: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "No. Documento:",
                        icon: Icon(Icons.card_membership),
                        hintText: "Escribe el número de documento",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      //controller: priceField,
                      onChanged:
                          (value) => bloc.add(UserChangeEvent(user: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: "Usuario:",
                        icon: Icon(Icons.email),
                        hintText: "Escribe el usuario",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      onChanged:
                          (value) => setState(() {
                            bloc.add(
                              PasswordChangeEventSignUp(password: value),
                            );
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validatePassword,
                      obscureText: !_showPasswordSignUp,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Escriba su Contraseña",
                        suffixIcon: InkWell(
                          onTap: () {
                            _autoShowTimerSignUp?.cancel();
                            if (!_showPasswordSignUp) {
                              _autoShowTimerSignUp = Timer(
                                Duration(seconds: 3),
                                () => setState(() {
                                  _showPasswordSignUp = false;
                                }),
                              );
                            }
                            setState(() {
                              _showPasswordSignUp = !_showPasswordSignUp;
                            });
                          },
                          child: Icon(
                            _showPasswordSignUp
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.0),
                    TextFormField(
                      // controller:urlField,
                      onChanged:
                          (value) => bloc.add(ImageChangeEvent(image: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "url Imagen:",
                        icon: Icon(Icons.image),
                        hintText: "Escribaa la URL De la imagen",
                      ),
                    ),
                    SizedBox(height: 48.0),

                    FilledButton(
                      onPressed:
                          isValidForm
                              ? () => {bloc.add(SubmitEventSignUp())}
                              : null, //hacer la logica
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Crear Usuario",
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
