// ignore: file_names
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/screens/Cart/cart_screen.dart';
import 'package:car_app/screens/Home/home.dart';
import 'package:car_app/screens/Orders/orders_screen.dart';
import 'package:car_app/screens/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import '../blocs/home_bloc/home_bloc.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({super.key, required this.homeState});

  final String homeState;
  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late List screens = [
    HomeScreen(),
    const OrdersScreen(),
    const CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Database().getUserDistance();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeStateDelivery) {
          print('object');
        }
        if (state is HomeStatePickUp) {
          print('pick up');
        }
        return Scaffold(
          body: screens[selectedIndex],
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(0),
            height: 60,
            child: BottomNavigationBar(
              elevation: 0,
              showUnselectedLabels: true,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              showSelectedLabels: true,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedIconTheme: IconThemeData(size: 18),
              unselectedIconTheme: IconThemeData(size: 18),
              unselectedLabelStyle: TextStyle(height: 0),
              currentIndex: selectedIndex,
              onTap: onItemTapped,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Bootstrap.house),
                    label: AppLocalizations.of(context)!.home),
                BottomNavigationBarItem(
                    icon: const Icon(BoxIcons.bx_food_menu),
                    label: AppLocalizations.of(context)!.orders),
                BottomNavigationBarItem(
                    icon: const Icon(Bootstrap.cart),
                    label: AppLocalizations.of(context)!.cart),
                BottomNavigationBarItem(
                    icon: const Icon(Bootstrap.person),
                    label: AppLocalizations.of(context)!.profile)
              ],
            ),
          ),
        );
      },
    );
  }
}
