
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pagina de Registro", style: TextStyle(fontSize: 40.0),),
            OutlinedButton(onPressed: () => GoRouter.of(context).pop(), child: Text("Ir a login"))
          ],
        )
      ) ,
    );
  }
}