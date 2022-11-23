import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile(
      {required this.location, required this.press, super.key});

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(FontAwesome.location_arrow),
              title: Text(
                location,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).colorScheme.tertiary,
        )
      ],
    );
  }
}
