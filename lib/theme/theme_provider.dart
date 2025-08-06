import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiproject/theme/theme_color.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppThemes.themes['Pink']!;
  String _currentTheme = 'Pink';

  ThemeData get themeData => _themeData;
  String get currentTheme => _currentTheme;

  ThemeProvider({required String initialTheme}) {
    _themeData = AppThemes.themes[initialTheme] ?? AppThemes.themes['Pink']!;
    _currentTheme = initialTheme;
  }

  void setTheme(String themeName) async {
    if (!AppThemes.themes.containsKey(themeName)) return;
    _themeData = AppThemes.themes[themeName]!;
    _currentTheme = themeName;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTheme', themeName);
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const ThemePickerDialog(),
        );
      },
      child: const Text('Choose Theme'),
    );
  }
}

class ThemePickerDialog extends StatelessWidget {
  const ThemePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Pick a Theme'),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: AppThemes.themes.entries.map((entry) {
            final color = entry.value.primaryColor;

            return GestureDetector(
              onTap: () {
                themeProvider.setTheme(entry.key);
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.key,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}










// class ThemePickerDialog extends StatelessWidget {
//   const ThemePickerDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//
//     return AlertDialog(
//       title: const Text('Pick a Theme'),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: Wrap(
//           spacing: 15,
//           runSpacing: 15,
//           children: AppThemes.themes.entries.map((entry) {
//             final color = entry.value.primaryColor;
//
//             return GestureDetector(
//               onTap: () {
//                 themeProvider.setTheme(entry.key);
//                 Navigator.of(context).pop();
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: color,
//                     radius: 24,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     entry.key,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//     );
//   }
// }