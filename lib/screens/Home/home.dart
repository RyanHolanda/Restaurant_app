import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/screens/Cart/cart_screen.dart';
import 'package:car_app/screens/Home/widgets/appbar.dart';
import 'package:car_app/screens/Home/widgets/items_list.dart';
import 'package:car_app/screens/Home/widgets/most_ordered_list.dart';
import 'package:car_app/screens/Home/widgets/pick_up_adress.dart';
import 'package:car_app/screens/Home/widgets/user_adress.dart';
import 'package:car_app/screens/Search%20Screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          Navigator.push(
              context,
              PageTransition(
                  child: const CartScreen(),
                  type: PageTransitionType.rightToLeftWithFade));
        }
      },
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70), child: MyAppBar()),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return LayoutBuilder(builder: (p0, p1) {
                    if (state is HomeStateDelivery) {
                      return const UserAdress();
                    }
                    if (state is HomeStatePickUp) {
                      return const PickUpAdress();
                    }
                    return const SizedBox.shrink();
                  });
                },
              ),
              const SearchBox(),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  AppLocalizations.of(context)!.mostordered,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const MostOrderedBurguersList(
                homeState: '',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  AppLocalizations.of(context)!.menu,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              BlocProvider(
                create: (context) => CartBloc(),
                child: ItemsList(
                    scrollController: _scrollController, homeState: ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: TextField(
            readOnly: true,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return SearchScreen(
                        homeState:
                            state is HomeStateDelivery ? 'Delivery' : 'Pick Up',
                      );
                    },
                  ),
                )),
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                hintText: 'Brutinho  •  Green Beard  •  Cheddar...',
                hintStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
