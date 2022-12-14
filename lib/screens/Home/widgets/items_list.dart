import 'package:car_app/models/items_model.dart';
import 'package:car_app/screens/Home/widgets/selected_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    Key? key,
    required this.homeState,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);
  final String homeState;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: itemsList.length,
      itemBuilder: (BuildContext context, int index) {
        itemsList.sort((a, b) => a.name.compareTo(b.name));
        return Column(
          children: [
            SizedBox(
              child: MaterialButton(
                onPressed: () {
                  itemsList.sort((a, b) => a.name.compareTo(b.name));
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SelectedItemScreen(
                            homeState: homeState,
                            paused: itemsList[index].paused,
                            price: double.parse(
                                itemsList[index].price.replaceAll(',', '.')),
                            imageUrl: itemsList[index].image,
                            name: itemsList[index].name,
                            description: itemsList[index].description,
                          ),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              itemsList[index].name,
                              style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                itemsList[index].description,
                                maxLines: 3,
                                style: GoogleFonts.inriaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                                overflow: TextOverflow.ellipsis,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'R\$ ${itemsList[index].price}',
                              style: GoogleFonts.inriaSans(
                                  fontSize: 12,
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
                          height: 70,
                          width: 70,
                          child: Image.network(
                            itemsList[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Divider(),
            )
          ],
        );
      },
    );
  }
}
