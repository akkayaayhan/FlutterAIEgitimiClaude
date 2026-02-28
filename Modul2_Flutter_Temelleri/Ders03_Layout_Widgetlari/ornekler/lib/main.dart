// Ders 03 — Layout Widget'ları: Çalışan Örnek
//
// KURULUM:
// 1. ornekler/ klasöründe terminal açın
// 2. flutter pub get
// 3. flutter run

import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Widget\'ları',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LayoutDemoEkrani(),
    );
  }
}

class LayoutDemoEkrani extends StatelessWidget {
  const LayoutDemoEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layout Demosu'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(text: 'Column/Row'),
              Tab(text: 'Stack'),
              Tab(text: 'Wrap'),
              Tab(text: 'ListView'),
              Tab(text: 'GridView'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ColumnRowSayfasi(),
            _StackSayfasi(),
            _WrapSayfasi(),
            _ListViewSayfasi(),
            _GridViewSayfasi(),
          ],
        ),
      ),
    );
  }
}

// ── Column & Row ─────────────────────────────────────────────────────

class _ColumnRowSayfasi extends StatelessWidget {
  const _ColumnRowSayfasi();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row: spaceBetween ────────────────────────────────
          _baslik('Row — spaceBetween'),
          Container(
            color: Colors.teal.shade50,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _renkliKutu(Colors.red, 'A'),
                _renkliKutu(Colors.green, 'B'),
                _renkliKutu(Colors.blue, 'C'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Row: Expanded ────────────────────────────────────
          _baslik('Row — Expanded (1:2:1 oran)'),
          Row(
            children: [
              Expanded(child: _renkliKutu(Colors.red, '1 pay', height: 50)),
              const SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: _renkliKutu(Colors.green, '2 pay', height: 50),
              ),
              const SizedBox(width: 4),
              Expanded(child: _renkliKutu(Colors.blue, '1 pay', height: 50)),
            ],
          ),
          const SizedBox(height: 16),

          // ── Column: crossAxisAlignment ───────────────────────
          _baslik('Column — crossAxisAlignment'),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('start', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(width: 60, height: 30, color: Colors.teal),
                      Container(width: 100, height: 30, color: Colors.teal.shade300),
                      Container(width: 40, height: 30, color: Colors.teal.shade100),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('center', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(width: 60, height: 30, color: Colors.orange),
                      Container(width: 100, height: 30, color: Colors.orange.shade300),
                      Container(width: 40, height: 30, color: Colors.orange.shade100),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('end', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(width: 60, height: 30, color: Colors.purple),
                      Container(width: 100, height: 30, color: Colors.purple.shade300),
                      Container(width: 40, height: 30, color: Colors.purple.shade100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Spacer ───────────────────────────────────────────
          _baslik('Row — Spacer'),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.menu),
                const SizedBox(width: 8),
                const Text('Başlık'),
                const Spacer(), // Geri kalanı doldur
                const Icon(Icons.search),
                const SizedBox(width: 8),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stack ─────────────────────────────────────────────────────────────

class _StackSayfasi extends StatelessWidget {
  const _StackSayfasi();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _baslik('Stack — Üst Üste Katmanlar'),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Container(color: Colors.blue.shade200),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 140,
                      height: 140,
                      color: Colors.green.shade300,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red.shade400,
                      child: const Center(
                        child: Text('Üstte', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Fotoğraf kartı (Stack kullanım örneği)
          _baslik('Stack — Fotoğraf Kartı'),
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // Arka plan (network image simülasyonu)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade700, Colors.teal.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.landscape, size: 80, color: Colors.white30),
              ),
              // Beğeni butonu (sağ üst)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
                ),
              ),
              // Alt bilgi şeridi
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Kapadokya', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Nevşehir, Türkiye', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Wrap ──────────────────────────────────────────────────────────────

class _WrapSayfasi extends StatelessWidget {
  const _WrapSayfasi();

  static const etiketler = [
    'Flutter', 'Dart', 'Android', 'iOS', 'Web',
    'Desktop', 'Firebase', 'REST API', 'BLoC', 'Riverpod',
    'Clean Architecture', 'Material 3',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _baslik('Wrap — Chip\'ler'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: etiketler
                .map((e) => Chip(
                      label: Text(e),
                      backgroundColor: Colors.teal.shade100,
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),

          _baslik('Wrap — Renkli Kutular'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              15,
              (i) => Container(
                width: (i % 3 + 1) * 50.0,
                height: 50,
                color: Colors.primaries[i % Colors.primaries.length].shade300,
                child: Center(child: Text('$i')),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _baslik('Wrap — Eylem Butonları'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(icon: const Icon(Icons.share), label: const Text('Paylaş'), onPressed: () {}),
              ElevatedButton.icon(icon: const Icon(Icons.bookmark_border), label: const Text('Kaydet'), onPressed: () {}),
              ElevatedButton.icon(icon: const Icon(Icons.comment), label: const Text('Yorum'), onPressed: () {}),
              ElevatedButton.icon(icon: const Icon(Icons.thumb_up_outlined), label: const Text('Beğen'), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

// ── ListView ──────────────────────────────────────────────────────────

class _ListViewSayfasi extends StatelessWidget {
  const _ListViewSayfasi();

  static final List<Map<String, dynamic>> kisiler = List.generate(
    20,
    (i) => {
      'isim': ['Ahmet', 'Zeynep', 'Murat', 'Fatma', 'Ali', 'Elif'][i % 6] + ' ${i + 1}',
      'unvan': ['Yazılımcı', 'Tasarımcı', 'Müdür', 'Analist'][i % 4],
      'online': i % 3 == 0,
    },
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: kisiler.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final kisi = kisiler[index];
        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.primaries[index % Colors.primaries.length].shade300,
                child: Text(
                  kisi['isim'].substring(0, 1),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              if (kisi['online'])
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(kisi['isim'], style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(kisi['unvan']),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () {},
        );
      },
    );
  }
}

// ── GridView ──────────────────────────────────────────────────────────

class _GridViewSayfasi extends StatelessWidget {
  const _GridViewSayfasi();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final renkler = Colors.primaries;
        final renk = renkler[index % renkler.length];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: renk.shade200,
                  child: Center(
                    child: Icon(Icons.image, size: 60, color: renk.shade700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ürün ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${(index + 1) * 99} TL',
                      style: TextStyle(color: renk.shade700, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Yardımcı fonksiyonlar ─────────────────────────────────────────────

Widget _renkliKutu(Color renk, String etiket, {double height = 60}) {
  return Container(
    height: height,
    color: renk,
    child: Center(
      child: Text(etiket, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

Widget _baslik(String metin) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      metin,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
    ),
  );
}
