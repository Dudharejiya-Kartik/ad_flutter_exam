import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProvider>(context, listen: false).fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    final countries = Provider.of<CountryProvider>(context).countries;

    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.of(context).pushNamed('/favourite');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(countries[index].flag),
            title: Text(countries[index].name),
            subtitle: Text(countries[index].capital),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/details', arguments: countries[index]);
            },
          );
        },
      ),
    );
  }
}
