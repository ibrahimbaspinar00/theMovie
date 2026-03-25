class AppYazilar {
  static String anaSayfa(String dilKodu) {
    return dilKodu == "en" ? "Home" : "Ana Sayfa";
  }

  static String favoriler(String dilKodu) {
    return dilKodu == "en" ? "Favorites" : "Favoriler";
  }

  static String ayarlar(String dilKodu) {
    return dilKodu == "en" ? "Settings" : "Ayarlar";
  }

  static String profil(String dilKodu) {
    return dilKodu == "en" ? "Profile" : "Profil";
  }
}