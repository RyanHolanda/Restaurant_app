import 'package:car_app/models/items_model.dart';
import 'package:car_app/screens/Home/widgets/selected_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class MostOrderedBurguersList extends StatelessWidget {
  const MostOrderedBurguersList({
    this.homeState,
    Key? key,
  }) : super(key: key);

  final String? homeState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              itemsList.sort(
                (a, b) => b.orders.compareTo(a.orders),
              );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    itemsList.sort(
                      (a, b) => b.orders.compareTo(a.orders),
                    );
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SelectedItemScreen(
                              homeState: homeState!,
                              paused: itemsList[index].paused,
                              price: double.parse(
                                  itemsList[index].price.replaceAll(',', '.')),
                              imageUrl: itemsList[index].image,
                              name: itemsList[index].name,
                              description: itemsList[index].description,
                            ),
                            type: PageTransitionType.rightToLeftWithFade));
                  },
                  child: SizedBox(
                      height: 60,
                      width: 130,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              itemsList[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                    colors: [Colors.black, Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(itemsList[index].name,
                                      style: GoogleFonts.inriaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            },
          )),
    );
  }
}
