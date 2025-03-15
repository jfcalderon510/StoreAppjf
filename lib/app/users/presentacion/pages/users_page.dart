import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeappv2/app/di/dependency_injection.dart';
import 'package:storeappv2/app/users/presentacion/bloc/users_bloc.dart';
import 'package:storeappv2/app/users/presentacion/bloc/users_event.dart';
import 'package:storeappv2/app/users/presentacion/bloc/users_state.dart';
import 'package:storeappv2/app/users/presentacion/model/users_model.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependecyInjection.serviceLocator.get<UsersBloc>(),
        child: Scaffold(
          appBar: AppBar(          
          title: Text("Listado de Usuarios"),
        ),
          body: ProductsListWidget(),         
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<UsersBloc>();
    return AppBar(
      backgroundColor: Colors.purple,
      title: Text(
        "Listado de Usuarios",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        InkWell(
          onTap:
              () => showDialog(
                context: context,
                builder:
                    (BuildContext context) => AlertDialog(
                      title: const Text('Cerrar Sesión'),
                      content: Text(
                        "Está seguro que desea Cerrar la Sesión",
                      ),
                      actions: <Widget>[                        
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancelar'),
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ),
              ),
          child: Icon(Icons.logout, color: Colors.white),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({super.key});

  @override
  State<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
   //print("Siiii");
   
    bloc.add(GetUsersEvent());
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case UsersErrorState():
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          bloc.add(GetUsersEvent());
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );         
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20.0),
                    Text(state.message),
                  ],
                ),
              ),
            );
          case EmptyState():
            return Center(child: Text("No se encontraron Usuarios"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductItemWidget(state.model.products[index]),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final UserModel product;

  const ProductItemWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return InkWell(    
        
      child: Card(
        child: Row(
          children: [
            Image.network(product.image, width: 150.0, fit: BoxFit.contain),
            Expanded(
              child: SizedBox(
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(product.name), 
                    Text(product.document),
                    Text(product.user)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
