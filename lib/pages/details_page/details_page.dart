import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/provider.dart';
import '../../model/model.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Country country =
        ModalRoute.of(context)!.settings.arguments as Country;

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(country.flag),
            Text(country.name, style: TextStyle(fontSize: 24)),
            Text('Capital: ${country.capital}'),
            Text('Region: ${country.region}'),
            ElevatedButton(
              onPressed: () {
                Provider.of<CountryProvider>(context, listen: false)
                    .saveCountry(country);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${country.name} saved!')));
              },
              child: Text('Save Country'),
            ),
          ],
        ),
      ),
    );
  }
}
