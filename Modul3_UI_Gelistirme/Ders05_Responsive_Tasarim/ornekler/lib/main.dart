// Ders 05 — Responsive Tasarım: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run
// TAVSİYE: flutter run -d chrome (tarayıcıda pencere boyutlandırın)
//          flutter run -d windows (pencere köşesinden boyutlandırın)

import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Tasarım',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const AnaSayfa(),
    );
  }
}

// ── Responsive Yardımcı Sınıf ────────────────────────────────────

class R {
  final double w;
  final double h;

  R.of(BuildContext context)
      : w = MediaQuery.sizeOf(context).width,
        h = MediaQuery.sizeOf(context).height;

  bool get mobil => w < 600;
  bool get tablet => w >= 600 && w < 900;
  bool get masaustu => w >= 900;

  String get boyutAdi {
    if (masaustu) return 'Masaüstü (≥900px)';
    if (tablet) return 'Tablet (600–899px)';
    return 'Mobil (<600px)';
  }

  T sec<T>({required T mobil, required T tablet, required T masaustu}) {
    if (this.masaustu) return masaustu;
    if (this.tablet) return tablet;
    return mobil;
  }
}

// ── Ürün Verisi ───────────────────────────────────────────────────

class Urun {
  final String ad;
  final String kategori;
  final double fiyat;
  final Color renk;
  final IconData ikon;

  const Urun({
    required this.ad,
    required this.kategori,
    required this.fiyat,
    required this.renk,
    required this.ikon,
  });
}

final List<Urun> urunler = [
  const Urun(ad: 'Flutter Kitabı', kategori: 'Eğitim', fiyat: 149, renk: Colors.blue, ikon: Icons.book),
  const Urun(ad: 'Dart Kursu', kategori: 'Video', fiyat: 299, renk: Colors.orange, ikon: Icons.play_circle),
  const Urun(ad: 'UI Kit Pro', kategori: 'Tasarım', fiyat: 89, renk: Colors.purple, ikon: Icons.design_services),
  const Urun(ad: 'Firebase', kategori: 'Backend', fiyat: 199, renk: Colors.red, ikon: Icons.cloud),
  const Urun(ad: 'Git Kılavuzu', kategori: 'Araç', fiyat: 69, renk: Colors.green, ikon: Icons.source),
  const Urun(ad: 'API Rehberi', kategori: 'Eğitim', fiyat: 129, renk: Colors.indigo, ikon: Icons.api),
  const Urun(ad: 'Test Paketi', kategori: 'Araç', fiyat: 79, renk: Colors.brown, ikon: Icons.bug_report),
  const Urun(ad: 'Animasyon', kategori: 'Tasarım', fiyat: 219, renk: Colors.amber, ikon: Icons.animation),
];

// ── Ana Sayfa ─────────────────────────────────────────────────────

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = R.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: r.masaustu
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Responsive Tasarım'),
                  Text(
                    '${r.w.toStringAsFixed(0)} × ${r.h.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 12, color: cs.onSurface.withValues(alpha: 0.6)),
                  ),
                ],
              )
            : const Text('Responsive Tasarım'),
        bottom: TabBar(
          controller: _tab,
          isScrollable: r.mobil,
          tabs: const [
            Tab(icon: Icon(Icons.grid_view), text: 'Katalog'),
            Tab(icon: Icon(Icons.vertical_split), text: 'Layout'),
            Tab(icon: Icon(Icons.screen_rotation), text: 'Yönlendirme'),
            Tab(icon: Icon(Icons.info_outline), text: 'Bilgi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          KatalogSayfasi(),
          LayoutSayfasi(),
          YonlendirmeSayfasi(),
          BilgiSayfasi(),
        ],
      ),
    );
  }
}

// ── 1. Katalog: Responsive Izgara ────────────────────────────────

class KatalogSayfasi extends StatelessWidget {
  const KatalogSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final r = R.of(context);

    // Kırılım noktasına göre ızgara ayarları
    final sutunSayisi = r.sec<int>(mobil: 1, tablet: 2, masaustu: 4);
    final aspectRatio = r.sec<double>(mobil: 3.5, tablet: 1.2, masaustu: 0.85);

    return Column(
      children: [
        // Boyut göstergesi bandı
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: r.masaustu
              ? Colors.green.shade100
              : r.tablet
                  ? Colors.blue.shade100
                  : Colors.orange.shade100,
          child: Row(
            children: [
              Icon(
                r.masaustu
                    ? Icons.desktop_windows
                    : r.tablet
                        ? Icons.tablet
                        : Icons.phone_android,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                '${r.boyutAdi} — $sutunSayisi sütun',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const Spacer(),
              Text(
                '${r.w.toStringAsFixed(0)}px',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),

        // Ürün ızgarası
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // LayoutBuilder: ebeveyn genişliğine göre sütun seç
              final ebeveynGenislik = constraints.maxWidth;
              int layoutSutun;
              if (ebeveynGenislik < 400) {
                layoutSutun = 1;
              } else if (ebeveynGenislik < 700) {
                layoutSutun = 2;
              } else {
                layoutSutun = 4;
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: layoutSutun,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: urunler.length,
                itemBuilder: (context, index) {
                  final urun = urunler[index];
                  // Mobilde liste görünümü, diğerlerinde kart
                  return r.mobil
                      ? _ListeUrunKarti(urun: urun)
                      : _IzgaraUrunKarti(urun: urun);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ListeUrunKarti extends StatelessWidget {
  final Urun urun;
  const _ListeUrunKarti({required this.urun});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: urun.renk.withValues(alpha: 0.15),
          child: Icon(urun.ikon, color: urun.renk),
        ),
        title: Text(urun.ad, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(urun.kategori),
        trailing: Text(
          '₺${urun.fiyat.toStringAsFixed(0)}',
          style: TextStyle(color: urun.renk, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _IzgaraUrunKarti extends StatelessWidget {
  final Urun urun;
  const _IzgaraUrunKarti({required this.urun});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: urun.renk.withValues(alpha: 0.12),
              child: Icon(urun.ikon, size: 40, color: urun.renk),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(urun.ad,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(urun.kategori,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                Text('₺${urun.fiyat.toStringAsFixed(0)}',
                    style: TextStyle(
                        color: urun.renk, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── 2. Layout Widget'ları ─────────────────────────────────────────

class LayoutSayfasi extends StatelessWidget {
  const LayoutSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Expanded ve Flexible
        _bolumBasligi('Expanded (flex oranı)'),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                  ),
                  alignment: Alignment.center,
                  child: Text('flex: 3',
                      style: TextStyle(color: cs.onPrimary, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: cs.secondary,
                  alignment: Alignment.center,
                  child: Text('flex: 2',
                      style: TextStyle(color: cs.onSecondary, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.tertiary,
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                  ),
                  alignment: Alignment.center,
                  child: Text('flex: 1',
                      style: TextStyle(color: cs.onTertiary, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Wrap
        _bolumBasligi('Wrap (taşanı alt satıra taşı)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Flutter', 'Dart', 'Firebase', 'REST API',
              'State Management', 'CI/CD', 'Testing', 'Pub.dev',
            ].map((e) => Chip(label: Text(e))).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // FittedBox
        _bolumBasligi('FittedBox (metnin ölçeklenmesi)'),
        const SizedBox(height: 8),
        ...['Kısa', 'Orta uzunlukta bir başlık', 'Bu çok uzun bir başlık metnidir sığması lazım'].map(
          (metin) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 48,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  metin,
                  style: TextStyle(
                    fontSize: 22,
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // AspectRatio
        _bolumBasligi('AspectRatio (16:9 video alanı)'),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_circle_filled, color: Colors.white, size: 60),
                SizedBox(height: 8),
                Text('16:9 AspectRatio', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Text(
      baslik,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }
}

// ── 3. Yönlendirme (OrientationBuilder) ──────────────────────────

class YonlendirmeSayfasi extends StatelessWidget {
  const YonlendirmeSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final dikeyMi = orientation == Orientation.portrait;
        final sutunSayisi = dikeyMi ? 2 : 4;

        return Column(
          children: [
            // Yönlendirme bandı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: dikeyMi ? Colors.indigo.shade50 : Colors.green.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    dikeyMi ? Icons.stay_current_portrait : Icons.stay_current_landscape,
                    color: dikeyMi ? Colors.indigo : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    dikeyMi
                        ? 'Dikey mod — 2 sütun'
                        : 'Yatay mod — 4 sütun',
                    style: TextStyle(
                      color: dikeyMi ? Colors.indigo : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Izgara
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: sutunSayisi,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: dikeyMi ? 1.0 : 1.5,
                ),
                itemCount: urunler.length,
                itemBuilder: (context, index) => _IzgaraUrunKarti(urun: urunler[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── 4. Bilgi Sayfası ─────────────────────────────────────────────

class BilgiSayfasi extends StatelessWidget {
  const BilgiSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final r = R.of(context);
    final cs = Theme.of(context).colorScheme;
    final yon = MediaQuery.orientationOf(context);
    final padding = MediaQuery.paddingOf(context);
    final piksel = MediaQuery.devicePixelRatioOf(context);

    final bilgiler = [
      ('Genişlik', '${r.w.toStringAsFixed(1)} px'),
      ('Yükseklik', '${r.h.toStringAsFixed(1)} px'),
      ('Boyut Sınıfı', r.boyutAdi),
      ('Yönlendirme', yon == Orientation.portrait ? 'Dikey' : 'Yatay'),
      ('Piksel Yoğunluğu', '${piksel.toStringAsFixed(2)}x'),
      ('Üst Padding', '${padding.top.toStringAsFixed(1)} px'),
      ('Alt Padding', '${padding.bottom.toStringAsFixed(1)} px'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: cs.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  r.masaustu
                      ? Icons.desktop_windows
                      : r.tablet
                          ? Icons.tablet_android
                          : Icons.phone_android,
                  size: 56,
                  color: cs.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  r.boyutAdi,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...bilgiler.map(
          (e) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              dense: true,
              title: Text(e.$1, style: TextStyle(color: cs.outline, fontSize: 13)),
              trailing: Text(
                e.$2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Kırılım noktaları görseli
        Text(
          'Kırılım Noktaları',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _KirilimGostergesi(mevcutGenislik: r.w),
      ],
    );
  }
}

class _KirilimGostergesi extends StatelessWidget {
  final double mevcutGenislik;
  const _KirilimGostergesi({required this.mevcutGenislik});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              _KirilimSegment(
                etiket: 'Mobil\n<600px',
                flex: 6,
                renk: Colors.orange,
                aktif: mevcutGenislik < 600,
              ),
              _KirilimSegment(
                etiket: 'Tablet\n600–899px',
                flex: 3,
                renk: Colors.blue,
                aktif: mevcutGenislik >= 600 && mevcutGenislik < 900,
              ),
              _KirilimSegment(
                etiket: 'Masaüstü\n≥900px',
                flex: 3,
                renk: Colors.green,
                aktif: mevcutGenislik >= 900,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mevcut genişlik: ${mevcutGenislik.toStringAsFixed(0)}px',
          style: TextStyle(fontSize: 12, color: cs.outline),
        ),
      ],
    );
  }
}

class _KirilimSegment extends StatelessWidget {
  final String etiket;
  final int flex;
  final Color renk;
  final bool aktif;

  const _KirilimSegment({
    required this.etiket,
    required this.flex,
    required this.renk,
    required this.aktif,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 64,
        color: aktif ? renk : renk.withValues(alpha: 0.2),
        alignment: Alignment.center,
        child: Text(
          etiket,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
            color: aktif ? Colors.white : renk,
          ),
        ),
      ),
    );
  }
}
