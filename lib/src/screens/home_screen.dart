import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cubit/src/cubit/auth_cubit.dart';
import 'package:prueba_cubit/src/cubit/auth_states.dart';
import 'package:prueba_cubit/src/screens/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return CupertinoButton(
                color: const Color.fromRGBO(139, 43, 215, 1),
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logOut();
                },
                child: const Text('Cerrar sesión'),
              );
            },
          ),
        ),
      ),
    );
  }
}
