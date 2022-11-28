// ignore: file_names
import 'package:car_app/screens/Cart/cart_screen.dart';
import 'package:car_app/screens/Home/home.dart';
import 'package:car_app/screens/Orders/orders_screen.dart';
import 'package:car_app/screens/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key, required this.homeState});

  final String homeState;
  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
  }

  late List screens = [
    HomeScreen(),
    const OrdersScreen(),
    CartScreen(homeState: widget.homeState),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 90,
        child: BottomNavigationBar(
          elevation: 0,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          showSelectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 14,
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
  }
}
