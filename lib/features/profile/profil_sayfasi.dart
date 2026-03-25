import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil UI',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        brightness: Brightness.light,
      ),
      home: const ProfilSayfasi(),
    );
  }
}

class ProfilSayfasi extends StatelessWidget {
  const ProfilSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ÜST PROFİL KARTI
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade400,
                  Colors.red.shade700,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 42,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  "İbrahim",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "ibrahim@example.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: const Text("Profili Düzenle"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // İSTATİSTİKLER
          Row(
            children: const [
              Expanded(
                child: ProfilIstatistikKutusu(
                  icon: Icons.favorite,
                  baslik: "Favori",
                  deger: "28",
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ProfilIstatistikKutusu(
                  icon: Icons.movie,
                  baslik: "İzlenen",
                  deger: "94",
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ProfilIstatistikKutusu(
                  icon: Icons.star,
                  baslik: "Puan",
                  deger: "4.8",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            "Hesap",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: const [
                ProfilMenuTile(
                  icon: Icons.person_outline,
                  title: "Kişisel Bilgiler",
                  subtitle: "Ad, e-posta ve hesap bilgileri",
                ),
                Divider(height: 1),
                ProfilMenuTile(
                  icon: Icons.lock_outline,
                  title: "Şifre ve Güvenlik",
                  subtitle: "Şifre değiştir, güvenlik ayarları",
                ),
                Divider(height: 1),
                ProfilMenuTile(
                  icon: Icons.credit_card_outlined,
                  title: "Abonelikler",
                  subtitle: "Plan ve ödeme bilgileri",
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Uygulama",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: const [
                ProfilMenuTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Tema",
                  subtitle: "Açık / koyu tema seçimi",
                ),
                Divider(height: 1),
                ProfilMenuTile(
                  icon: Icons.language_outlined,
                  title: "Dil",
                  subtitle: "Türkçe / English",
                ),
                Divider(height: 1),
                ProfilMenuTile(
                  icon: Icons.notifications_none,
                  title: "Bildirimler",
                  subtitle: "Bildirim tercihlerini yönet",
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Destek",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: const [
                ProfilMenuTile(
                  icon: Icons.help_outline,
                  title: "Yardım Merkezi",
                  subtitle: "SSS ve destek sayfası",
                ),
                Divider(height: 1),
                ProfilMenuTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Gizlilik Politikası",
                  subtitle: "Veri ve kullanım politikaları",
                ),
                Divider(height: 1),
                ProfilMenuTile(
                  icon: Icons.info_outline,
                  title: "Uygulama Hakkında",
                  subtitle: "Sürüm ve uygulama bilgileri",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text("Çıkış Yap"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ProfilIstatistikKutusu extends StatelessWidget {
  final IconData icon;
  final String baslik;
  final String deger;

  const ProfilIstatistikKutusu({
    super.key,
    required this.icon,
    required this.baslik,
    required this.deger,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Column(
          children: [
            Icon(icon, color: Colors.red),
            const SizedBox(height: 8),
            Text(
              deger,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              baslik,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfilMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {},
    );
  }
}