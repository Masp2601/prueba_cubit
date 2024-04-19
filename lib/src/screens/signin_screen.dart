import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_cubit/src/cubit/auth_cubit.dart';
import 'package:prueba_cubit/src/cubit/auth_states.dart';
import 'package:prueba_cubit/src/screens/verify_phone_screen.dart';
import 'package:prueba_cubit/src/widgets/reusable_text.dart';
import 'package:country_picker/country_picker.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Variable para almacenar el país seleccionado
  Country? selectedCountry;

  Country country = Country(
    phoneCode: '57',
    countryCode: 'COL',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'COL',
    example: 'COL',
    displayName: 'Colombia',
    displayNameNoCountryCode: 'COL',
    e164Key: '',
  );

  PreferredSize appBar(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width <= 600;

    if (isSmallScreen) {
      return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color.fromRGBO(139, 43, 215, 1),
            ),
            onPressed: () {},
          ),
          title: const Text(
            'Atras',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color.fromRGBO(139, 43, 215, 1),
            ),
            onPressed: () {},
          ),
          title: const Text(
            'Atrás',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // Imagen lateral
                  if (isLargeScreen)
                    Expanded(
                      flex: 2,
                      child: ClipRect(
                        child: SizedBox(
                          child: Image.asset(
                            "assets/images/Imagen_lateral.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  // Columna para los campos de entrada y el botón
                  if (isLargeScreen) const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          return Padding(
                            padding: const EdgeInsets.all(150.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Contenido de la columna
                                Column(
                                  children: [
                                    const ReusableText(
                                      text:
                                          'Ingresa tu número de celular para iniciar',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Mostrar el selector de país
                                            showCountryPicker(
                                              context: context,
                                              countryListTheme:
                                                  CountryListThemeData(
                                                backgroundColor: Colors.white,
                                                bottomSheetHeight: 825.h * 0.8,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.h),
                                                  topRight:
                                                      Radius.circular(12.h),
                                                ),
                                              ),
                                              onSelect: (code) {
                                                // Almacenar el país seleccionado
                                                setState(() {
                                                  country = code;
                                                });
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ReusableText(
                                              // Mostrar el código del país seleccionado
                                              text:
                                                  '${country.flagEmoji} + ${country.phoneCode}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Número de celular',
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthCodeSentState) {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const VerifyPhoneNumber(),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthLoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: GestureDetector(
                                        onTap: () {
                                          String phoneNumber =
                                              "+${country.phoneCode}${phoneController.text}";
                                          BlocProvider.of<AuthCubit>(context)
                                              .sendOTP(phoneNumber);
                                        },
                                        child: Image.asset(
                                          "assets/images/Continuar.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Contenido de la columna
                              Column(
                                children: [
                                  const ReusableText(
                                    text: 'Ingresa tu número de celular',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Mostrar el selector de país
                                          showCountryPicker(
                                            context: context,
                                            countryListTheme:
                                                CountryListThemeData(
                                              backgroundColor: Colors.white,
                                              bottomSheetHeight: 825.h * 0.8,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.h),
                                                topRight: Radius.circular(12.h),
                                              ),
                                            ),
                                            onSelect: (code) {
                                              // Almacenar el país seleccionado
                                              setState(() {
                                                country = code;
                                              });
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ReusableText(
                                            // Mostrar el código del país seleccionado
                                            text:
                                                '${country.flagEmoji} + ${country.phoneCode}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: phoneController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Número de celular',
                                            hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthCodeSentState) {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const VerifyPhoneNumber(),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AuthLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onTap: () {
                                        String phoneNumber =
                                            "+${country.phoneCode}${phoneController.text}";
                                        BlocProvider.of<AuthCubit>(context)
                                            .sendOTP(phoneNumber);
                                      },
                                      child: Image.asset(
                                        "assets/images/Continuar.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
