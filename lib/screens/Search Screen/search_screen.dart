import 'package:car_app/models/items_model.dart';
import 'package:car_app/screens/Home/widgets/selected_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({required this.homeState, super.key});

  final String homeState;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ItemModel> displayList = [];

  void updateList(String value) {
    setState(() {
      displayList = itemsList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) => updateList(value),
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.search),
                          hintText: 'Brutinho  •  Green Beard  •  Cheddar...',
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: displayList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          itemsList.sort((a, b) => a.name.compareTo(b.name));
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SelectedItemScreen(
                                    homeState: widget.homeState,
                                    paused: displayList[index].paused,
                                    price: double.parse(displayList[index]
                                        .price
                                        .replaceAll(',', '.')),
                                    imageUrl: displayList[index].image,
                                    name: displayList[index].name,
                                    description: displayList[index].description,
                                  ),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      displayList[index].name,
                                      style: GoogleFonts.inriaSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        displayList[index].description,
                                        maxLines: 3,
                                        style: GoogleFonts.inriaSans(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onTertiary),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'R\$ ${displayList[index].price}',
                                      style: GoogleFonts.inriaSans(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    displayList[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Divider(),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
