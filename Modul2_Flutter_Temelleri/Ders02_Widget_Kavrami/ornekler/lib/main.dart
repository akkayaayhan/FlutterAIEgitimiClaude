// Ders 02 — Widget Kavramı: Çalışan Örnek
//
// KURULUM:
// 1. flutter create ders02_widget_kavrami
// 2. Bu dosyanın içeriğini lib/main.dart ile değiştirin
// 3. flutter run

import 'package:flutter/material.dart';

void main() {
  runApp(const UygulamaNokta());
}

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Kavramı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Keşfi'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profil Kartı ────────────────────────────────────────
            _profilKarti(context),
            const SizedBox(height: 24),

            // ── Başlık ──────────────────────────────────────────────
            _bolumBasligi('Temel Widget\'lar'),
            const SizedBox(height: 12),

            // ── Text örnekleri ─────────────────────────────────────
            _textOrnekleri(context),
            const SizedBox(height: 24),

            // ── İkon örnekleri ─────────────────────────────────────
            _bolumBasligi('İkonlar'),
            const SizedBox(height: 12),
            _ikonOrnekleri(),
            const SizedBox(height: 24),

            // ── Container örnekleri ────────────────────────────────
            _bolumBasligi('Container'),
            const SizedBox(height: 12),
            _containerOrnekleri(),
            const SizedBox(height: 24),

            // ── Buton örnekleri ────────────────────────────────────
            _bolumBasligi('Butonlar'),
            const SizedBox(height: 12),
            _butonOrnekleri(),
            const SizedBox(height: 24),

            // ── Gradient kart ──────────────────────────────────────
            _bolumBasligi('Gradient Container'),
            const SizedBox(height: 12),
            _gradientKart(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Yeni Ekle'),
      ),
    );
  }

  // ── Profil Kartı Widget'ı ────────────────────────────────────────

  Widget _profilKarti(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(width: 16),
          // Bilgiler
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ahmet Yılmaz',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Flutter Geliştirici',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      'İstanbul, Türkiye',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Takip et butonu
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Takip'),
          ),
        ],
      ),
    );
  }

  // ── Text Örnekleri ───────────────────────────────────────────────

  Widget _textOrnekleri(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Başlık — H1',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          'Alt Başlık — H2',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'Gövde metni — normal yazı boyutu',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Text(
          'Kalın, italik, renklı metin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.deepPurple,
          ),
        ),
        const Text(
          'Bu çok uzun bir metin örneğidir ve bir satıra sığmadığı zaman üç nokta ile kısaltılır...',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // ── İkon Örnekleri ───────────────────────────────────────────────

  Widget _ikonOrnekleri() {
    final ikonlar = [
      (Icons.home, Colors.blue, 'home'),
      (Icons.favorite, Colors.red, 'favorite'),
      (Icons.star, Colors.amber, 'star'),
      (Icons.shopping_cart, Colors.green, 'cart'),
      (Icons.notifications, Colors.orange, 'notif'),
      (Icons.settings, Colors.grey, 'settings'),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: ikonlar
          .map(
            (item) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.$1, color: item.$2, size: 32),
                const SizedBox(height: 4),
                Text(item.$3, style: const TextStyle(fontSize: 11)),
              ],
            ),
          )
          .toList(),
    );
  }

  // ── Container Örnekleri ──────────────────────────────────────────

  Widget _containerOrnekleri() {
    return Row(
      children: [
        // Düz renkli
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text('Düz renk')),
          ),
        ),
        const SizedBox(width: 8),
        // Kenarlıklı
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text('Kenarlıklı')),
          ),
        ),
        const SizedBox(width: 8),
        // Gölgeli
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
              ],
            ),
            child: const Center(child: Text('Gölgeli')),
          ),
        ),
      ],
    );
  }

  // ── Buton Örnekleri ──────────────────────────────────────────────

  Widget _butonOrnekleri() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
        TextButton(onPressed: () {}, child: const Text('Text')),
        OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Gönder'),
        ),
        ElevatedButton(onPressed: null, child: const Text('Devre Dışı')),
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {},
        ),
      ],
    );
  }

  // ── Gradient Kart ────────────────────────────────────────────────

  Widget _gradientKart() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6750A4), Color(0xFF03DAC6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          'Gradient Arka Plan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  // ── Bölüm Başlığı ────────────────────────────────────────────────

  Widget _bolumBasligi(String baslik) {
    return Text(
      baslik,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.deepPurple,
      ),
    );
  }
}
