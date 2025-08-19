import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:uiproject/component/header_appbar.dart';

class CurrencySelectScreen extends StatefulWidget {
  @override
  _CurrencySelectScreenState createState() => _CurrencySelectScreenState();
}

class _CurrencySelectScreenState extends State<CurrencySelectScreen> {
  Currency? selectedCurrency;
  String? selectedFlag; // 🔹 Store selected flag
  List<Currency> currencyList = [];
  List<Currency> filteredCurrencies = [];

  @override
  void initState() {
    super.initState();
    currencyList = CurrencyService().getAll();
    filteredCurrencies = currencyList;
  }

  void _filterCurrencies(String query) {
    setState(() {
      filteredCurrencies = currencyList.where((currency) {
        final code = currency.code.toLowerCase();
        final name = currency.name.toLowerCase();
        return code.contains(query.toLowerCase()) ||
            name.contains(query.toLowerCase());
      }).toList();
    });
  }

  // Function to convert country code → flag emoji
  String countryCodeToEmoji(String countryCode) {
    if (countryCode.length != 2) return '';
    return String.fromCharCodes(
      countryCode.toUpperCase().codeUnits.map((codeUnit) => codeUnit + 127397),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Choose a currency'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      body: Column(
        children: [
          HeaderAppbar(title: "Choose a currency"),
          // Search box
          Padding(
            padding: const EdgeInsets.only(top: 2.0,bottom: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor:Theme.of(context).colorScheme.primary.withOpacity(.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterCurrencies,
            ),
          ),

          // Currency list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredCurrencies.length,
              itemBuilder: (context, index) {
                var currency = filteredCurrencies[index];
                String flagEmoji = countryCodeToEmoji(
                  currency.code.substring(0, 2),
                );

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Text(flagEmoji, style: TextStyle(fontSize: 24)),
                    title: Text(currency.code),
                    subtitle: Text(currency.name),
                    trailing: selectedCurrency?.code == currency.code
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedCurrency = currency;
                        selectedFlag = flagEmoji; // 🔹 Save flag here
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Save button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(

              onPressed: () {
                if (selectedCurrency != null && selectedFlag != null) {
                  print(
                      "Selected Currency: ${selectedCurrency!.code} $selectedFlag");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowCurrency(
                        currency: selectedCurrency!.code,
                        flag: selectedFlag!, // 🔹 Pass flag
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a currency")),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),

                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowCurrency extends StatefulWidget {
  final String currency;
  final String flag; // 🔹 Added flag

  const ShowCurrency({
    super.key,
    required this.currency,
    required this.flag,
  });

  @override
  State<ShowCurrency> createState() => _ShowCurrencyState();
}

class _ShowCurrencyState extends State<ShowCurrency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.flag, // 🔹 Show flag
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 10),
            Text(
              widget.currency,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:currency_picker/currency_picker.dart';
//
// class CurrencyPickerScreen extends StatefulWidget {
//   @override
//   _CurrencyPickerScreenState createState() => _CurrencyPickerScreenState();
// }
//
// class _CurrencyPickerScreenState extends State<CurrencyPickerScreen> {
//   Currency? selectedCurrency;
//   List<Currency> currencyList = [];
//   List<Currency> filteredCurrencies = [];
//
//   @override
//   void initState() {
//     super.initState();
//     currencyList = CurrencyService().getAll();
//     filteredCurrencies = currencyList;
//   }
//
//   void _filterCurrencies(String query) {
//     setState(() {
//       filteredCurrencies = currencyList.where((currency) {
//         final code = currency.code.toLowerCase();
//         final name = currency.name.toLowerCase();
//         return code.contains(query.toLowerCase()) ||
//             name.contains(query.toLowerCase());
//       }).toList();
//     });
//   }
//
//   // Function to convert country code → flag emoji
//   String countryCodeToEmoji(String countryCode) {
//     if (countryCode.length != 2) return '';
//     return String.fromCharCodes(
//       countryCode.toUpperCase().codeUnits.map((codeUnit) => codeUnit + 127397),
//     ); // Unicode offset for regional flags
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose a currency'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           // Search box
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               onChanged: _filterCurrencies,
//             ),
//           ),
//
//           // Currency list
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredCurrencies.length,
//               itemBuilder: (context, index) {
//                 var currency = filteredCurrencies[index];
//                 String flagEmoji = countryCodeToEmoji(
//                   currency.code.substring(0, 2),
//                 );
//
//                 return ListTile(
//                   leading: Text(flagEmoji, style: TextStyle(fontSize: 24)),
//                   title: Text(currency.code),
//                   subtitle: Text(currency.name),
//                   trailing: selectedCurrency?.code == currency.code
//                       ? Icon(Icons.check, color: Colors.green)
//                       : null,
//                   onTap: () {
//                     setState(() {
//                       selectedCurrency = currency;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//
//           // Save button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (selectedCurrency != null) {
//                   print("Selected Currency: ${selectedCurrency!.code}");
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           ShowCurrency(currency: selectedCurrency!.code),
//                     ),
//                   );
//
//                   //  Navigator.pushNamed(context, selectedCurrency);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Please select a currency")),
//                   );
//                 }
//               },
//               child: Text(
//                 'Save',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).colorScheme.primary,
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ShowCurrency extends StatefulWidget {
//   final String currency;
//   const ShowCurrency({super.key, required this.currency});
//
//   @override
//   State<ShowCurrency> createState() => _ShowCurrencyState();
// }
//
// class _ShowCurrencyState extends State<ShowCurrency> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [Text(widget.currency, style: TextStyle(fontSize: 20))],
//           ),
//         ),
//       ),
//     );
//   }
// }
