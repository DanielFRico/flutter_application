import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/app/dependency_injection/di.dart';
import 'package:namer_app/app/home/presentation/bloc/home_bloc.dart';
import 'package:namer_app/app/home/presentation/bloc/home_event.dart';
import 'package:namer_app/app/home/presentation/bloc/home_state.dart';
import 'package:namer_app/app/home/presentation/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60), child: AppBarWidget()),
          body: const ProductsListWidget(),
          floatingActionButton: FloatingActionButton(
              onPressed: () => GoRouter.of(context).pushNamed("form-product")),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return AppBar(
      backgroundColor: Colors.purple,
      title: const Text(
        "Listado de productos",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        InkWell(
          onTap: () => bloc.add(LogoutEvent()),
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }
}

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductsListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case HomeErrorState():
            AlertDialog(
              title: const Text("Error"),
              content: const Text("Hubo un eeror trayendo los productos"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                      bloc.add(GetProductsEvent());
                    },
                    child: const Text("Aceptar"))
              ],
            );
            break;
          case LogoutState():
            GoRouter.of(context).goNamed("login");
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Text(state.message);
          case EmptyState():
            return const Center(child: Text("nooooo se encontraron productos"));
          case LoadDataState():
            return ListView.builder(
                itemCount: state.model.products.length,
                itemBuilder: (context, index) =>
                    ProductItemWidget(state.model.products[index]));
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductItemWidget(
    this.productModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onLongPress: () => showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Eliminación de producto:"),
                content: const Text("Estas seguro de eliminar este producto?"),
                actions: [
                  TextButton(
                      onPressed: () => {
                            Navigator.pop(context, 'OK'),
                            bloc.add(DeleteProductEvent(id: productModel.id))
                          },
                      child: const Text("Sí")),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancelar"))
                ],
              ))),
      child: Card(
          child: Row(children: [
        Image.network(
          productModel.imageUrl,
          width: 150,
          fit: BoxFit.contain,
        ),
        Expanded(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(productModel.name),
                Text(productModel.price.toString()),
              ],
            ),
          ),
        )
      ])),
    );
  }
}
