// Ders 01 — Material Design Bileşenleri: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run

import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Bileşenler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AnaSayfa(),
    );
  }
}

// ── Ana Sayfa ─────────────────────────────────────────────────────

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _aktifSayfa = 0;

  // Chip seçimleri
  final List<String> _etiketler = ['Flutter', 'Dart', 'Firebase', 'UI/UX'];
  final Set<String> _seciliEtiketler = {'Flutter'};

  // ── SnackBar göster ──────────────────────────────────────────────
  void _snackBarGoster(String mesaj, {bool hata = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mesaj),
        backgroundColor: hata ? Colors.red.shade700 : Colors.indigo,
        duration: const Duration(seconds: 2),
        action: hata
            ? SnackBarAction(
                label: 'GERİ AL',
                textColor: Colors.white,
                onPressed: () {},
              )
            : null,
      ),
    );
  }

  // ── AlertDialog göster ───────────────────────────────────────────
  Future<void> _silmeOnayi() async {
    final onaylandi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber, color: Colors.orange, size: 40),
        title: const Text('Emin misiniz?'),
        content: const Text('Bu öğeyi silmek istediğinizden emin misiniz?\nBu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (onaylandi == true && mounted) {
      _snackBarGoster('Öğe silindi', hata: true);
    }
  }

  // ── BottomSheet göster ───────────────────────────────────────────
  void _altPaneliGoster() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tutma çubuğu
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Seçenekler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.indigo),
              title: const Text('Düzenle'),
              onTap: () {
                Navigator.pop(ctx);
                _snackBarGoster('Düzenleme açıldı');
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.green),
              title: const Text('Paylaş'),
              onTap: () {
                Navigator.pop(ctx);
                _snackBarGoster('Paylaşıldı');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Sil', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(ctx);
                _silmeOnayi();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Sayfa içerikleri ────────────────────────────────────────────

  Widget _butonlarSayfasi() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Başlık
          _bolumBasligi('Buton Türleri'),
          const SizedBox(height: 12),

          // ElevatedButton
          ElevatedButton.icon(
            onPressed: () => _snackBarGoster('ElevatedButton tıklandı'),
            icon: const Icon(Icons.save),
            label: const Text('ElevatedButton — Kaydet'),
          ),
          const SizedBox(height: 10),

          // OutlinedButton
          OutlinedButton.icon(
            onPressed: () => _snackBarGoster('OutlinedButton tıklandı'),
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('OutlinedButton — İptal'),
          ),
          const SizedBox(height: 10),

          // TextButton
          TextButton.icon(
            onPressed: () => _snackBarGoster('TextButton tıklandı'),
            icon: const Icon(Icons.info_outline),
            label: const Text('TextButton — Bilgi'),
          ),
          const SizedBox(height: 16),

          // İkonlar satırı
          _bolumBasligi('IconButton\'lar'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ikonButon(Icons.favorite, Colors.red, 'Beğen'),
              _ikonButon(Icons.share, Colors.green, 'Paylaş'),
              _ikonButon(Icons.bookmark, Colors.orange, 'Kaydet'),
              _ikonButon(Icons.more_vert, Colors.grey, 'Daha Fazla'),
            ],
          ),
          const SizedBox(height: 24),

          // Dialog + BottomSheet
          _bolumBasligi('Dialog & BottomSheet'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _silmeOnayi,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('AlertDialog Göster'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: _altPaneliGoster,
            child: const Text('BottomSheet Göster'),
          ),
        ],
      ),
    );
  }

  Widget _kartlarSayfasi() {
    final urunler = [
      {'ad': 'Flutter Kitabı', 'fiyat': '₺149', 'renk': Colors.blue, 'ikon': Icons.book},
      {'ad': 'Dart Kursu', 'fiyat': '₺299', 'renk': Colors.orange, 'ikon': Icons.play_circle},
      {'ad': 'UI Şablonu', 'fiyat': '₺89', 'renk': Colors.purple, 'ikon': Icons.design_services},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Chip filtreler
        _bolumBasligi('FilterChip'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _etiketler.map((etiket) {
            final secili = _seciliEtiketler.contains(etiket);
            return FilterChip(
              label: Text(etiket),
              selected: secili,
              onSelected: (deger) {
                setState(() {
                  if (deger) {
                    _seciliEtiketler.add(etiket);
                  } else {
                    _seciliEtiketler.remove(etiket);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Ürün kartları
        _bolumBasligi('Card Örnekleri'),
        const SizedBox(height: 12),
        ...urunler.map((urun) => _urunKarti(urun)),
      ],
    );
  }

  Widget _hakkindaSayfasi() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade300, Colors.indigo.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.flutter_dash, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Material Design Demo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Ders 01 — Material Design Bileşenleri',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),

          // Özellik kartları
          _ozellikKarti(Icons.palette, 'Material 3', 'useMaterial3: true ile modern görünüm'),
          _ozellikKarti(Icons.touch_app, 'Butonlar', '5 farklı buton türü'),
          _ozellikKarti(Icons.view_agenda, 'Card', 'İçerik kutusu ve ListTile'),
          _ozellikKarti(Icons.label, 'Chip', 'Etiket ve filtre bileşeni'),
          _ozellikKarti(Icons.notifications, 'SnackBar', 'Alt bildirim çubuğu'),
          _ozellikKarti(Icons.open_in_new, 'Dialog', 'AlertDialog ve BottomSheet'),
        ],
      ),
    );
  }

  // ── Yardımcı widget'lar ─────────────────────────────────────────

  Widget _bolumBasligi(String baslik) {
    return Text(
      baslik,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: Colors.indigo,
      ),
    );
  }

  Widget _ikonButon(IconData ikon, Color renk, String tooltip) {
    return Column(
      children: [
        IconButton(
          icon: Icon(ikon, color: renk),
          tooltip: tooltip,
          onPressed: () => _snackBarGoster('$tooltip tıklandı'),
          style: IconButton.styleFrom(
            backgroundColor: renk.withValues(alpha: 0.1),
          ),
        ),
        Text(tooltip, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _urunKarti(Map<String, dynamic> urun) {
    final renk = urun['renk'] as Color;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: renk.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(urun['ikon'] as IconData, color: renk, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    urun['ad'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    urun['fiyat'] as String,
                    style: TextStyle(color: renk, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: _altPaneliGoster,
            ),
          ],
        ),
      ),
    );
  }

  Widget _ozellikKarti(IconData ikon, String baslik, String aciklama) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade50,
          child: Icon(ikon, color: Colors.indigo),
        ),
        title: Text(baslik, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(aciklama),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final sayfalar = [
      _butonlarSayfasi(),
      _kartlarSayfasi(),
      _hakkindaSayfasi(),
    ];

    return Scaffold(
      // ── AppBar
      appBar: AppBar(
        title: const Text('Material Bileşenler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Ara',
            onPressed: () => _snackBarGoster('Arama açıldı'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Bildirimler',
            onPressed: () => _snackBarGoster('Bildirim yok'),
          ),
        ],
      ),

      // ── Drawer (Yan Menü)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.indigo.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  SizedBox(height: 12),
                  Text('Flutter Öğrencisi',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('ogr@flutter.dev',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Ana Sayfa'),
              selected: _aktifSayfa == 0,
              onTap: () {
                setState(() => _aktifSayfa = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Kartlar'),
              selected: _aktifSayfa == 1,
              onTap: () {
                setState(() => _aktifSayfa = 1);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Hakkında'),
              onTap: () {
                setState(() => _aktifSayfa = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ── Body
      body: sayfalar[_aktifSayfa],

      // ── FAB
      floatingActionButton: _aktifSayfa == 0
          ? FloatingActionButton.extended(
              onPressed: () => _snackBarGoster('Yeni öğe eklendi!'),
              icon: const Icon(Icons.add),
              label: const Text('Yeni Ekle'),
            )
          : null,

      // ── Bottom Navigation Bar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _aktifSayfa,
        onDestinationSelected: (index) => setState(() => _aktifSayfa = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.widgets_outlined), selectedIcon: Icon(Icons.widgets), label: 'Butonlar'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined), selectedIcon: Icon(Icons.credit_card), label: 'Kartlar'),
          NavigationDestination(icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info), label: 'Hakkında'),
        ],
      ),
    );
  }
}
