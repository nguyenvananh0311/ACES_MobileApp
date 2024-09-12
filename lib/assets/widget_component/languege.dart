import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  LanguageSelector({required this.onLocaleChange, });

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = null;
    _loadLocale();
  }

  _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString('locale');
    setState(() {
        _selectedLocale = Locale(localeCode ?? 'en', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: _buildFlagIcon(_selectedLocale),
      onSelected: (locale) async {
        setState(() {
          _selectedLocale = locale;
        });
        widget.onLocaleChange(locale);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('locale', locale.languageCode);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: const Locale('en', ''),
            child: Row(
              children: [
                Image.asset('lib/assets/flags/en.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const Text('English'),
              ],
            ),
          ),
          PopupMenuItem(
            value: const Locale('vi', ''),
            child: Row(
              children: [
                Image.asset('lib/assets/flags/vn.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const Text('Tiếng Việt'),
              ],
            ),
          ),
          PopupMenuItem(
            value: const Locale('km', ''),
            child: Row(
              children: [
                Image.asset('lib/assets/flags/km.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const Text('ភាសាខ្មែរ'),
              ],
            ),
          ),
        ];
      },
    );
  }

  Widget _buildFlagIcon(Locale? locale) {
    if(locale == null) {
      return const SizedBox(width: 30,);
    }
    switch (locale.languageCode) {
      case 'vi':
        return Row(
          children: [
            Image.asset('lib/assets/flags/vn.png', width: 30, height: 30),
          ],
        ) ;
      case 'km':
        return Row(
          children: [
            Image.asset('lib/assets/flags/km.png', width: 30, height: 30),
          ],
        ) ;
      case 'en':
      default:
      return Row(
        children: [
          Image.asset('lib/assets/flags/en.png', width: 30, height: 30),
        ],
      ) ;
    }
  }
}

