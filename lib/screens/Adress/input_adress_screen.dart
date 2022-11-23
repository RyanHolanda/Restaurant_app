import 'package:car_app/models/adress_auto_complete_response.dart';
import 'package:car_app/models/adress_autocomplete_prediction.dart';
import 'package:car_app/repos/adress_repo.dart';
import 'package:car_app/screens/Adress/complement_adress_screen.dart';
import 'package:car_app/screens/Adress/widgets/location_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';

class InputAdressScreen extends StatefulWidget {
  const InputAdressScreen({super.key});

  @override
  State<InputAdressScreen> createState() => _InputAdressScreenState();
}

class _InputAdressScreenState extends State<InputAdressScreen> {
  final apiKey = 'AIzaSyCnx9hbNv0odIKzkH7ogSHM7gJfPD-iiHY';
  List<AutocompletePrediction> placePredition = [];
  void placeAutoComplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com",
        '/maps/api/place/autocomplete/json', {"input": query, "key": apiKey});
    String? response = await AdressAutoCompleteRepo.fetchurl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredition = result.predictions!;
        });
      }
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: const Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
              title: Text(
                AppLocalizations.of(context)!.addAnAdress,
                style: GoogleFonts.inriaSans(
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            body: Column(
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      onChanged: (value) {
                        placeAutoComplete(value);
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: AppLocalizations.of(context)!.enterAnAddress,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          child: Icon(FontAwesome.location_arrow),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: placePredition.length,
                      itemBuilder: (context, index) => LocationListTile(
                          location: placePredition[index].description!,
                          press: () async {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ComplementAdressScreen(
                                      adrees:
                                          placePredition[index].description!,
                                    ),
                                    type: PageTransitionType.fade));
                          })),
                )
              ],
            ),
          );
  }
}
