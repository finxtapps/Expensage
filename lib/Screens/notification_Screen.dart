import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'message': 'Hi , Your balance is on track.',
      'emoji': '😍',
      // Light pink
    },
    {'message': '', 'emoji': '', },
    {'message': '', 'emoji': '', },
    {'message': '', 'emoji': '', },
  ];

   NotificationsScreen({Key? key}) : super(key: key); // ✅ Constructor

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:isDarkMode? Theme.of(context).colorScheme.primary: Colors.white,
      appBar: AppBar(
        backgroundColor:isDarkMode? Theme.of(context).colorScheme.primary: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color:isDarkMode? Colors.white: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'Notifications',
          style: TextStyle(
            color:isDarkMode? Colors.white: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:isDarkMode?Theme.of(context).scaffoldBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color:isDarkMode? Colors.white: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      notifications[index]['message'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (notifications[index]['emoji'] != '')
                    Text(
                      notifications[index]['emoji'],
                      style: const TextStyle(fontSize: 24),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
