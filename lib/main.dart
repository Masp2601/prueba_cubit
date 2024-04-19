import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_cubit/firebase_options.dart';
import 'package:prueba_cubit/src/cubit/auth_cubit.dart';
import 'package:prueba_cubit/src/cubit/auth_states.dart';
import 'package:prueba_cubit/src/screens/home_screen.dart';
import 'package:prueba_cubit/src/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) {
                return previous is AuthInitianState;
              },
              builder: (context, state) {
                if (state is AuthLoggedInState) {
                  return const HomeScreen();
                } else if (state is AuthLoggedOutState) {
                  return const SignInScreen();
                } else {
                  return const SignInScreen();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
