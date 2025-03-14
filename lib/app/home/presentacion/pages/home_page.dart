import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:storeappv2/app/di/dependency_injection.dart';
import 'package:storeappv2/app/home/presentacion/bloc/home_bloc.dart';
import 'package:storeappv2/app/home/presentacion/bloc/home_event.dart';
import 'package:storeappv2/app/home/presentacion/bloc/home_state.dart';
import 'package:storeappv2/app/home/presentacion/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependecyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBarWidget(),
          ),
          body: ProductsListWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orangeAccent,
            onPressed: () => GoRouter.of(context).pushNamed("form-product"),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return AppBar(
      backgroundColor: Colors.purple,
      title: Text(
        "Listado de Productos",
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
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            bloc.add(LogOutEvent());
                          },
                          child: const Text('OK'),
                        ),
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
    final bloc = context.read<HomeBloc>();
   //print("Siiii");
   
    bloc.add(GetProductsEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case HomeErrorState():
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
                          bloc.add(GetProductsEvent());
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          case LogOutState():        
            GoRouter.of(context).goNamed("login");
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
            return Center(child: Text("No se encontraron productos"));
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
  final ProductModel product;

  const ProductItemWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onTap:
          () => GoRouter.of(
            context,
          ).pushNamed("form-product-u", pathParameters: {"id": product.id}),
      // onTap: () => GoRouter.of(context).pushNamed("form-product-u"),
      onLongPress:
          () => showDialog(
            context: context,
            builder:
                (BuildContext context) => AlertDialog(
                  title: const Text('Eliminación de Producto'),
                  content: Text(
                    "Está seguro de eliminar este producto?: ${product.name}",
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        bloc.add(DeleteProductEven(id: product.id));
                      },
                      child: const Text('OK'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
          ),
      child: Card(
        child: Row(
          children: [
            Image.network(product.urlImage, width: 150.0, fit: BoxFit.contain),
            Expanded(
              child: SizedBox(
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text(product.name), Text("\$${product.price}")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
