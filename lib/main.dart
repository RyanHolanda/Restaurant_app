import 'package:car_app/NavBar/Bottom_Nav_Bar.dart';
import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/firebase/auth/auth.dart';
import 'package:car_app/blocs/app_bloc.dart';
import 'package:car_app/screens/Loading/loading_screen.dart';
import 'package:car_app/screens/Welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                secondaryContainer: Colors.white,
                primary: const Color.fromARGB(255, 0, 0, 0),
                onPrimary: Colors.grey.shade300,
                secondary: Colors.white,
                onSecondary: Colors.white,
                tertiary: Colors.grey.shade300,
                onTertiary: Colors.grey.shade600,
                error: Colors.red,
                onError: Colors.red,
                background: const Color.fromARGB(255, 255, 255, 255),
                onBackground: Colors.blue,
                surface: const Color.fromARGB(255, 255, 255, 255),
                primaryContainer: const Color.fromARGB(255, 255, 255, 255),
                onSurface: const Color.fromARGB(255, 255, 255, 255))),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color.fromARGB(255, 13, 13, 13),
            colorScheme: ColorScheme(
                brightness: Brightness.dark,
                secondaryContainer: Colors.grey.shade900,
                tertiary: Colors.grey.shade900,
                onTertiary: Colors.grey.shade600,
                primary: const Color.fromARGB(255, 255, 255, 255),
                onPrimary: Colors.grey.shade900,
                secondary: const Color.fromARGB(255, 13, 13, 13),
                onSecondary: const Color.fromARGB(255, 255, 255, 255),
                error: Colors.red,
                onError: Colors.red,
                background: Colors.blue,
                onBackground: const Color.fromARGB(255, 255, 255, 255),
                surface: Colors.black,
                primaryContainer: Colors.black,
                onSurface: Colors.black)),
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: StreamBuilder(
            stream: Auth().authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                context.read<AppBloc>().add(AppEventGetData());
              }
              return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
                if (state is AppStateLoggedIn) {
                  if (state.isLoading == true) {
                    return const LoadingScreen();
                  } else {
                    return BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return MyBottomNavBar(
                          homeState: state is HomeStateDelivery
                              ? 'Delivery'
                              : 'Pick Up',
                        );
                      },
                    );
                  }
                }
                if (state is AppStateLoggedOut ||
                    state is AppStateAuthError ||
                    state is AppStateSendResetEmail) {
                  return const WelcomeScreen();
                } else {
                  return Container();
                }
              });
            }),
      ),
    );
  }
}
