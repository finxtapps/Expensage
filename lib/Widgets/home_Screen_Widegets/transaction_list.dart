import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Map<String, dynamic>> transactions = [
    {
      'date': DateTime.now().subtract(Duration(days: 1)),
      'company': 'Flipkart',
      'icon': Icons.shopping_bag,
      'iconColor': Colors.black,
      'amount': -350.00,
      'amountColor': Colors.red,
    },
    {
      'date': DateTime.now().subtract(Duration(days: 5)),
      'company': 'Youtube',
      'icon': Icons.play_arrow,
      'iconColor': Colors.red,
      'amount': -700.00,
      'amountColor': Colors.red,
    },
    {
      'date': DateTime.now().subtract(Duration(days: 20)),
      'company': 'Money Transfer',
      'icon': Icons.swap_horiz,
      'iconColor': Colors.black,
      'amount': 1250.00,
      'amountColor': Colors.green,
    },
    {
      'date': DateTime.now().subtract(Duration(days: 45)),
      'company': 'Books',
      'icon': Icons.menu_book,
      'iconColor': Colors.orange,
      'amount': -1100.00,
      'amountColor': Colors.red,
    },
    {
      'date': DateTime.now().subtract(Duration(days: 100)),
      'company': 'Shopping',
      'icon': Icons.shopping_cart,
      'iconColor': Colors.pink,
      'amount': -3000.00,
      'amountColor': Colors.red,
    },
  ];

  String _selectedFilter = 'Lifetime';
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _filteredTransactions = [];

  final GlobalKey _filterIconKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _filterTransactions(_selectedFilter);
  }

  void _filterTransactions(String filter) async {
    DateTime now = DateTime.now();
    DateTime startDate;

    if (filter == 'Lifetime') {
      setState(() {
        _filteredTransactions = [...transactions];
        _filteredTransactions.sort(
              (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
        );
        _selectedDate = null;
        _selectedFilter = filter;
      });
      return;
    }

    if (filter == 'Date') {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        setState(() {
          _selectedDate = picked;
          _filteredTransactions = transactions.where((tx) {
            final txDate = tx['date'] as DateTime;
            return txDate.year == picked.year &&
                txDate.month == picked.month &&
                txDate.day == picked.day;
          }).toList();

          _filteredTransactions.sort(
                (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
          );

          _selectedFilter = 'Date';
        });
      }
      return;
    }

    switch (filter) {
      case 'Weekly':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'Monthly':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case 'Yearly':
        startDate = DateTime(now.year - 1, now.month, now.day);
        break;
      default:
        startDate = DateTime(2000);
    }

    setState(() {
      _selectedDate = null;
      _filteredTransactions = transactions.where((tx) {
        DateTime txDate = tx['date'] as DateTime;
        return txDate.isAfter(startDate) || txDate.isAtSameMomentAs(startDate);
      }).toList();

      _filteredTransactions.sort(
            (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
      );

      _selectedFilter = filter;
    });
  }

  void _showFilterDrawer() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final List<String> options = ['Lifetime', 'Weekly', 'Monthly', 'Yearly', 'Date'];

    final RenderBox renderBox = _filterIconKey.currentContext?.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter',
      barrierColor: Colors.transparent,
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            Positioned(
              top: position.dy + renderBox.size.height + 5,
              right: MediaQuery.of(context).size.width - position.dx - renderBox.size.width,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  constraints: const BoxConstraints(maxHeight: 280),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: options.map((option) {
                        return CheckboxListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectedFilter == option,
                          title: Text(
                            option,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (_) {
                            Navigator.pop(context);
                            _filterTransactions(option);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: anim,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final secondaryColor = themeProvider.themeData.colorScheme.secondary.withOpacity(0.1);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.white.withOpacity(0.15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 12),
                      child: GestureDetector(
                        onTap: _showFilterDrawer,
                        child: SizedBox(
                          child: FaIcon(
                            FontAwesomeIcons.filter,
                            key: _filterIconKey,
                            color: isDarkMode ? Colors.orange : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Transaction list container
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade500,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: _filteredTransactions.isEmpty
                        ? const Center(child: Text('No transactions found.'))
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = _filteredTransactions[index];

                        return Container(
                          height: screenWidth * 0.15,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Theme.of(context).scaffoldBackgroundColor
                                : secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Date
                              SizedBox(
                                width: screenWidth * 0.12,
                                child: Text(
                                  DateFormat('MMM\nd').format(transaction['date']),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.028,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : Colors.grey[600],
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),

                              // Icon
                              Container(
                                width: screenWidth * 0.1,
                                height: screenWidth * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Icon(
                                  transaction['icon'] as IconData,
                                  color: transaction['iconColor'] as Color,
                                  size: screenWidth * 0.05,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),

                              // Company
                              Expanded(
                                child: Text(
                                  transaction['company'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.042,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ),

                              // Amount
                              Text(
                                '\$${transaction['amount'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: transaction['amountColor'],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}





























// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// import '../../theme/theme_provider.dart';
// import '../ExpenseScreenWidget/time_filter_dropdown.dart'; // 🔁 Apne theme provider ka correct path lagayein
//
// class TransactionList extends StatefulWidget {
//   const TransactionList({super.key});
//
//   @override
//   State<TransactionList> createState() => _TransactionListState();
// }
//
// class _TransactionListState extends State<TransactionList> {
//   final transactions = [
//     {
//       'date': 'Mar\n17',
//       'company': 'Flipkart',
//       'icon': Icons.shopping_bag,
//       'iconColor': Colors.black,
//       'amount': '-\$350.00',
//       'amountColor': Colors.red,
//     },
//     {
//       'date': 'Mar\n15',
//       'company': 'Youtube',
//       'icon': Icons.play_arrow,
//       'iconColor': Colors.red,
//       'amount': '-\$700.00',
//       'amountColor': Colors.red,
//     },
//     {
//       'date': 'Mar\n12',
//       'company': 'Money Transfer',
//       'icon': Icons.swap_horiz,
//       'iconColor': Colors.black,
//       'amount': '+\$1250.00',
//       'amountColor': Colors.green,
//     },
//     {
//       'date': 'Mar\n10',
//       'company': 'Books',
//       'icon': Icons.menu_book,
//       'iconColor': Colors.orange,
//       'amount': '-\$1100.00',
//       'amountColor': Colors.red,
//     },
//     {
//       'date': 'Mar\n8',
//       'company': 'Shopping',
//       'icon': Icons.shopping_cart,
//       'iconColor': Colors.pink,
//       'amount': '-\$3000.00',
//       'amountColor': Colors.red,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, _) {
//         final secondaryColor = themeProvider.themeData.colorScheme.secondary.withOpacity(0.1);
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Transaction History Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Transaction History',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   Text(
//                     'See all',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//
//               // Transaction List Container
//               Container(
//
//                 decoration: BoxDecoration(
//                   //color: Colors.cyanAccent.withOpacity(.2),
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: Colors.grey.shade500,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//
//                   mainAxisSize: MainAxisSize.min,
//                    crossAxisAlignment:  CrossAxisAlignment.start,
//
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                           children: [
//                             Row(
//                               children: [
//                                 Text("Filter",style: TextStyle(fontSize: 16),),
//                                 SizedBox(width: 10),
//                                 Icon(Icons.filter_list_sharp)
//                               ],
//                             ),
//                             TimeFilterDropdown(),
//
//
//                           ],
//                         ),
//                       ),
//
//                     Padding(
//                       padding:  EdgeInsets.only(left:  8.0,right: 8,top: 0),
//                       child: ListView.builder(
//
//                        physics:  NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: transactions.length,
//
//                         itemBuilder: (context, index) {
//                           final transaction = transactions[index];
//                           return Container(
//                             height: screenWidth * 0.15,
//                             margin: const EdgeInsets.only(bottom: 12),
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
//                             decoration: BoxDecoration(
//                               color: secondaryColor,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: Colors.grey[200]!,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 // Date
//                                 SizedBox(
//                                   width: screenWidth * 0.12,
//                                   child: Text(
//                                     transaction['date'] as String,
//                                     style: TextStyle(
//                                       fontSize: screenWidth * 0.028,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[600],
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.04),
//
//                                 // Icon
//                                 Container(
//                                   width: screenWidth * 0.1,
//                                   height: screenWidth * 0.1,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(40),
//                                   ),
//                                   child: Icon(
//                                     transaction['icon'] as IconData,
//                                     color: transaction['iconColor'] as Color,
//                                     size: screenWidth * 0.05,
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.04),
//
//                                 // Company Name
//                                 Expanded(
//                                   child: Text(
//                                     transaction['company'] as String,
//                                     style: TextStyle(
//                                       fontSize: screenWidth * 0.042,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ),
//
//                                 // Amount
//                                 Text(
//                                   transaction['amount'] as String,
//                                   style: TextStyle(
//                                     fontSize: screenWidth * 0.035,
//                                     fontWeight: FontWeight.w600,
//                                     color: transaction['amountColor'] as Color,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
