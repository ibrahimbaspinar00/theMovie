// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'The Movie DB';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get favorites => 'Favoriler';

  @override
  String get settings => 'Ayarlar';

  @override
  String get profile => 'Profil';

  @override
  String get popular => 'Popüler';

  @override
  String get upcoming => 'Yakında Gelecek';

  @override
  String get topRated => 'En Çok İzlenenler';

  @override
  String get noDataInCategory => 'Bu kategoride veri yok';

  @override
  String get changeLanguage => 'Dili Değiştir';
}
