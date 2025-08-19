import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:provider/provider.dart';

import '../theme/header_Color.dart';
import '../theme/theme_provider.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Country> allCountries = [];
  List<Country> filteredCountries = [];
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    // Get all countries from country_picker package
    allCountries = CountryService().getAll();
    filteredCountries = allCountries;
  }

  void filterCountries(String query) {
    setState(() {
      filteredCountries = allCountries
          .where((country) =>
      country.name.toLowerCase().contains(query.toLowerCase()) ||
          country.countryCode
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          country.phoneCode.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
              themeProvider.currentTheme == 'Pink'
                  ? HeaderColor.pinkGradient
                  : themeProvider.currentTheme == 'Green'
                  ? HeaderColor.greenGradient
                  : themeProvider.currentTheme == 'Blue'
                  ? HeaderColor.blueGradient
                  : themeProvider.currentTheme == 'Orange'
                  ? HeaderColor.orangeGradient
                  : HeaderColor.darkGradient,
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:  const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Location'
                          ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Select your current location",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              "We require your area code and location for SMS registration confirmation.",
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Find your country...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color:Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: filterCountries,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    leading: Text(country.flagEmoji, style: TextStyle(fontSize: 24)),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: country.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Radio<Country>(
                      value: country,
                      groupValue: selectedCountry,
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                  ),



                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  onPressed: () {
                    if (selectedCountry != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text("Selected: ${selectedCountry!.name}")),
                      );
                    }
                  },
                  child: Text("Save", style: TextStyle(fontSize: 18,color:Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
