import 'package:car_app/firebase/auth/auth.dart';
import 'package:car_app/blocs/app_bloc.dart';
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/screens/Home/widgets/appbar.dart';
import 'package:car_app/screens/Home/widgets/items_list.dart';
import 'package:car_app/screens/Home/widgets/most_ordered_list.dart';
import 'package:car_app/screens/Home/widgets/pick_up_adress.dart';
import 'package:car_app/screens/Home/widgets/user_adress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final user = Auth().currentUser;
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: () =>
                      context.read<AppBloc>().add(AppEventSignOut())),
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(70), child: MyAppBar()),
              body: SingleChildScrollView(
                physics:  const BouncingScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(builder: (p0, p1) {
                      if (state is HomeStateDelivery) {
                        return const UserAdress();
                      }
                      if (state is HomeStatePickUp) {
                        return const PickUpAdress();
                      }
                      return const SizedBox.shrink();
                    }),
                    const SearchBox(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.mostordered,
                        style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const MostOrderedBurguersList(),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.menu,
                        style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ItemsList(scrollController: _scrollController),
                  ],
                ),
              ),
            ),
          );
        },
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
      padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: TextField(
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

