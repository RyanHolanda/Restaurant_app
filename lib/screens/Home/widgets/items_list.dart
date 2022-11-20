import 'package:car_app/models/items_model.dart';
import 'package:car_app/screens/Home/widgets/selected_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20),
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: itemsList.length,
      itemBuilder: (BuildContext context, int index) {
        itemsList.sort((a, b) => a.name.compareTo(b.name));
        return Column(
          children: [
            MaterialButton(
              onPressed: () {
                itemsList.sort((a, b) => a.name.compareTo(b.name));
                Navigator.push(
                    context,
                    PageTransition(
                        child: SelectedItemScreen(
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
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              itemsList[index].description,
                              maxLines: 3,
                              style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'R\$ ${itemsList[index].price}',
                            style: GoogleFonts.inriaSans(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 100,
                        width: 100,
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            )
          ],
        );
      },
    );
  }
}
