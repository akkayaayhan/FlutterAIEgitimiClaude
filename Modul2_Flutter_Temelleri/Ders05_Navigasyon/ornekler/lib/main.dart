// Ders 05 — Navigasyon: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run

import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigasyon Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // İsimli rotalar
      initialRoute: '/',
      routes: {
        '/': (context) => const AnaSayfa(),
        '/ayarlar': (context) => const AyarlarSayfasi(),
      },
    );
  }
}

// ── Ana Sayfa ──────────────────────────────────────────────────────

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  String _sonMesaj = 'Henüz bir seçim yapılmadı';

  final List<Map<String, dynamic>> _urunler = [
    {'id': 1, 'ad': 'Flutter Kitabı', 'fiyat': 149.90, 'renk': Colors.blue},
    {'id': 2, 'ad': 'Dart Kursu', 'fiyat': 299.00, 'renk': Colors.orange},
    {'id': 3, 'ad': 'VS Code Teması', 'fiyat': 49.90, 'renk': Colors.purple},
    {'id': 4, 'ad': 'Firebase Paketi', 'fiyat': 199.00, 'renk': Colors.red},
    {'id': 5, 'ad': 'UI Kit', 'fiyat': 89.90, 'renk': Colors.green},
  ];

  // Detay sayfasından dönerken veri al
  Future<void> _detayaGit(Map<String, dynamic> urun) async {
    final sonuc = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => UrunDetaySayfasi(urun: urun),
      ),
    );

    if (sonuc != null && mounted) {
      setState(() => _sonMesaj = sonuc);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(sonuc),
          backgroundColor: Colors.teal,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Listesi'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/ayarlar'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Son mesaj bandı
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.teal.shade50,
            child: Text(
              _sonMesaj,
              style: TextStyle(color: Colors.teal.shade700, fontSize: 13),
            ),
          ),
          // Ürün listesi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _urunler.length,
              itemBuilder: (context, index) {
                final urun = _urunler[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (urun['renk'] as Color).withOpacity(0.2),
                      child: Icon(Icons.shopping_bag, color: urun['renk'] as Color),
                    ),
                    title: Text(
                      urun['ad'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('₺${(urun['fiyat'] as double).toStringAsFixed(2)}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _detayaGit(urun),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Özel animasyonlu buton
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HakkindaSayfasi(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        },
        icon: const Icon(Icons.info_outline),
        label: const Text('Hakkında'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ── Ürün Detay Sayfası ────────────────────────────────────────────

class UrunDetaySayfasi extends StatelessWidget {
  final Map<String, dynamic> urun;

  const UrunDetaySayfasi({super.key, required this.urun});

  @override
  Widget build(BuildContext context) {
    final renk = urun['renk'] as Color;

    return Scaffold(
      appBar: AppBar(
        title: Text(urun['ad'] as String),
        backgroundColor: renk,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ürün görseli (simüle)
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: renk.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: renk.withOpacity(0.3)),
              ),
              child: Icon(Icons.shopping_bag, size: 80, color: renk),
            ),
            const SizedBox(height: 24),

            // Ürün adı
            Text(
              urun['ad'] as String,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Fiyat
            Text(
              '₺${(urun['fiyat'] as double).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                color: renk,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Açıklama (simüle)
            const Text(
              'Bu ürün Flutter geliştiricileri için özenle hazırlanmıştır. '
              'Yüksek kalite ve içerik zenginliğiyle öğrenme sürecinizi hızlandırır.',
              style: TextStyle(color: Colors.grey, height: 1.5),
            ),
            const Spacer(),

            // Sepete ekle → veriyi geri döndür
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(
                  context,
                  '✅ "${urun['ad']}" sepete eklendi — ₺${(urun['fiyat'] as double).toStringAsFixed(2)}',
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Sepete Ekle', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: renk,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 12),

            // Geri dön (veri olmadan)
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Ayarlar Sayfası (İsimli Rota) ────────────────────────────────

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool _bildirimler = true;
  bool _karanlikMod = false;
  String _dil = 'Türkçe';

  // Değişiklik varsa geri tuşunu yakala
  bool _degistirildi = false;

  Future<bool> _geriGitmeyiOnayla() async {
    if (!_degistirildi) return true;

    final cikMi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Değişiklikleri kaydet?'),
        content: const Text('Kaydedilmemiş değişiklikleriniz var.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Çıkış'),
          ),
          ElevatedButton(
            onPressed: () {
              // Kaydet ve çık
              Navigator.pop(ctx, true);
            },
            child: const Text('Kaydet ve Çık'),
          ),
        ],
      ),
    );
    return cikMi ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _geriGitmeyiOnayla,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ayarlar'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Bildirimler',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                  letterSpacing: 1,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text('Push Bildirimleri'),
              subtitle: const Text('Yeni ürünler ve kampanyalar'),
              value: _bildirimler,
              onChanged: (v) => setState(() {
                _bildirimler = v;
                _degistirildi = true;
              }),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Görünüm',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                  letterSpacing: 1,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text('Karanlık Mod'),
              subtitle: const Text('Gözleri yormayan koyu tema'),
              value: _karanlikMod,
              onChanged: (v) => setState(() {
                _karanlikMod = v;
                _degistirildi = true;
              }),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Dil',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                  letterSpacing: 1,
                ),
              ),
            ),
            ...['Türkçe', 'English', 'Deutsch'].map(
              (dil) => RadioListTile<String>(
                title: Text(dil),
                value: dil,
                groupValue: _dil,
                onChanged: (v) => setState(() {
                  _dil = v!;
                  _degistirildi = true;
                }),
                activeColor: Colors.teal,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _degistirildi = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ayarlar kaydedildi')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Kaydet'),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton(
                onPressed: () {
                  // Tüm yığını temizleyip ana sayfaya dön
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                child: const Text('Ana Sayfaya Dön (Yığını Temizle)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hakkında Sayfası (Özel Animasyon ile Açılan) ──────────────────

class HakkindaSayfasi extends StatelessWidget {
  const HakkindaSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkında'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flutter_dash, size: 60, color: Colors.teal),
              ),
              const SizedBox(height: 24),
              const Text(
                'Navigasyon Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Flutter Eğitim Serisi\nDers 05 — Navigasyon',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text('v1.0.0', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 48),
              const _NavOzeti(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavOzeti extends StatelessWidget {
  const _NavOzeti();

  @override
  Widget build(BuildContext context) {
    final satirlar = [
      ('push()', 'Yeni sayfa ekle'),
      ('pop()', 'Geri dön'),
      ('pushNamed()', 'İsimli rotaya git'),
      ('pushReplacement()', 'Mevcut sayfayı değiştir'),
      ('WillPopScope', 'Geri tuşunu yönet'),
    ];

    return Column(
      children: satirlar.map((s) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.teal, size: 18),
              const SizedBox(width: 8),
              Text(
                s.$1,
                style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '— ${s.$2}',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
