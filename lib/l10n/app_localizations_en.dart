// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'The Movie DB';

  @override
  String get home => 'Home';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get popular => 'Popular';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get topRated => 'Top Rated';

  @override
  String get noDataInCategory => 'No data in this category';

  @override
  String get changeLanguage => 'Change Language';
}
