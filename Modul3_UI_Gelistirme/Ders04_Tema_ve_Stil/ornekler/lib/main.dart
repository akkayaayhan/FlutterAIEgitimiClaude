// Ders 04 — Tema ve Stil: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run

import 'package:flutter/material.dart';

// ── Tema Tanımları ─────────────────────────────────────────────────

// Mevcut tema renkleri (seçilebilir)
const List<({String ad, Color renk})> temaRenkleri = [
  (ad: 'İndigo', renk: Colors.indigo),
  (ad: 'Mor', renk: Colors.purple),
  (ad: 'Kırmızı', renk: Colors.red),
  (ad: 'Turuncu', renk: Colors.orange),
  (ad: 'Yeşil', renk: Colors.green),
  (ad: 'Teal', renk: Colors.teal),
];

ThemeData _temaOlustur(Color tohum, Brightness parlaklik) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: tohum,
      brightness: parlaklik,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    ),
  );
}

// ── Uygulama Kökü ─────────────────────────────────────────────────

void main() => runApp(const TemaUygulamasi());

class TemaUygulamasi extends StatefulWidget {
  const TemaUygulamasi({super.key});

  @override
  State<TemaUygulamasi> createState() => _TemaUygulamasiState();
}

class _TemaUygulamasiState extends State<TemaUygulamasi> {
  ThemeMode _temaMode = ThemeMode.light;
  Color _tohum = Colors.indigo;

  void _temaModeDegistir(ThemeMode mod) => setState(() => _temaMode = mod);
  void _renkDegistir(Color renk) => setState(() => _tohum = renk);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tema ve Stil',
      debugShowCheckedModeBanner: false,
      theme: _temaOlustur(_tohum, Brightness.light),
      darkTheme: _temaOlustur(_tohum, Brightness.dark),
      themeMode: _temaMode,
      home: AnaSayfa(
        temaMode: _temaMode,
        seciliRenk: _tohum,
        onTemaModeDegistir: _temaModeDegistir,
        onRenkDegistir: _renkDegistir,
      ),
    );
  }
}

// ── Ana Sayfa ─────────────────────────────────────────────────────

class AnaSayfa extends StatefulWidget {
  final ThemeMode temaMode;
  final Color seciliRenk;
  final ValueChanged<ThemeMode> onTemaModeDegistir;
  final ValueChanged<Color> onRenkDegistir;

  const AnaSayfa({
    super.key,
    required this.temaMode,
    required this.seciliRenk,
    required this.onTemaModeDegistir,
    required this.onRenkDegistir,
  });

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

  bool get _koyuMu => widget.temaMode == ThemeMode.dark ||
      (widget.temaMode == ThemeMode.system &&
          WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema ve Stil'),
        backgroundColor: cs.surface,
        actions: [
          // Koyu/Açık toggle
          IconButton(
            icon: Icon(_koyuMu ? Icons.light_mode : Icons.dark_mode),
            tooltip: _koyuMu ? 'Açık Temaya Geç' : 'Koyu Temaya Geç',
            onPressed: () => widget.onTemaModeDegistir(
              _koyuMu ? ThemeMode.light : ThemeMode.dark,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Renkler'),
            Tab(text: 'Tipografi'),
            Tab(text: 'Bileşenler'),
            Tab(text: 'Marka Kiti'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _RenklerSayfasi(
            seciliRenk: widget.seciliRenk,
            onRenkDegistir: widget.onRenkDegistir,
          ),
          const _TipografiSayfasi(),
          const _BilesenlerSayfasi(),
          const _MarkaKitiSayfasi(),
        ],
      ),
    );
  }
}

// ── 1. Renkler Sayfası ────────────────────────────────────────────

class _RenklerSayfasi extends StatelessWidget {
  final Color seciliRenk;
  final ValueChanged<Color> onRenkDegistir;

  const _RenklerSayfasi({required this.seciliRenk, required this.onRenkDegistir});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final paletRenkleri = [
      ('primary', cs.primary, cs.onPrimary),
      ('onPrimary', cs.onPrimary, cs.primary),
      ('primaryContainer', cs.primaryContainer, cs.onPrimaryContainer),
      ('secondary', cs.secondary, cs.onSecondary),
      ('secondaryContainer', cs.secondaryContainer, cs.onSecondaryContainer),
      ('tertiary', cs.tertiary, cs.onTertiary),
      ('surface', cs.surface, cs.onSurface),
      ('error', cs.error, cs.onError),
      ('outline', cs.outline, cs.surface),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Tohum rengi seçici
        const Text('Tema Rengini Seç',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: temaRenkleri.map((t) {
            final secili = t.renk.toARGB32() == seciliRenk.toARGB32();
            return GestureDetector(
              onTap: () => onRenkDegistir(t.renk),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: t.renk,
                  shape: BoxShape.circle,
                  border: secili
                      ? Border.all(color: cs.outline, width: 3)
                      : null,
                  boxShadow: secili
                      ? [BoxShadow(color: t.renk.withValues(alpha: 0.5), blurRadius: 8, spreadRadius: 2)]
                      : null,
                ),
                child: secili
                    ? const Icon(Icons.check, color: Colors.white, size: 24)
                    : null,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Otomatik oluşturulan palet
        const Text('Oluşturulan Renk Paleti',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        ...paletRenkleri.map(
          (entry) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            height: 52,
            decoration: BoxDecoration(
              color: entry.$2,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              entry.$1,
              style: TextStyle(
                color: entry.$3,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── 2. Tipografi Sayfası ──────────────────────────────────────────

class _TipografiSayfasi extends StatelessWidget {
  const _TipografiSayfasi();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final stiller = [
      ('displayLarge', tt.displayLarge),
      ('displayMedium', tt.displayMedium),
      ('displaySmall', tt.displaySmall),
      ('headlineLarge', tt.headlineLarge),
      ('headlineMedium', tt.headlineMedium),
      ('headlineSmall', tt.headlineSmall),
      ('titleLarge', tt.titleLarge),
      ('titleMedium', tt.titleMedium),
      ('titleSmall', tt.titleSmall),
      ('bodyLarge', tt.bodyLarge),
      ('bodyMedium', tt.bodyMedium),
      ('bodySmall', tt.bodySmall),
      ('labelLarge', tt.labelLarge),
      ('labelMedium', tt.labelMedium),
      ('labelSmall', tt.labelSmall),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: stiller.length,
      separatorBuilder: (_, __) => Divider(color: cs.outlineVariant, height: 1),
      itemBuilder: (context, index) {
        final (ad, stil) = stiller[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  ad,
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.outline,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Expanded(
                child: Text('Flutter', style: stil),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── 3. Bileşenler Sayfası ─────────────────────────────────────────

class _BilesenlerSayfasi extends StatefulWidget {
  const _BilesenlerSayfasi();

  @override
  State<_BilesenlerSayfasi> createState() => _BilesenlerSayfasiState();
}

class _BilesenlerSayfasiState extends State<_BilesenlerSayfasi> {
  bool _switch = true;
  double _slider = 0.6;
  bool _checkbox = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Butonlar
        Text('Butonlar', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
            FilledButton(onPressed: () {}, child: const Text('Filled')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            TextButton(onPressed: () {}, child: const Text('Text')),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add)),
            FloatingActionButton(onPressed: () {}, child: const Icon(Icons.edit)),
            FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.star),
              label: const Text('Favoriye Ekle'),
            ),
          ],
        ),
        const Divider(height: 28),

        // Kontroller
        Text('Kontroller', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        SwitchListTile(
          title: const Text('Switch'),
          value: _switch,
          onChanged: (v) => setState(() => _switch = v),
        ),
        CheckboxListTile(
          title: const Text('Checkbox'),
          value: _checkbox,
          onChanged: (v) => setState(() => _checkbox = v!),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        Slider(
          value: _slider,
          onChanged: (v) => setState(() => _slider = v),
          label: '${(_slider * 100).round()}%',
          divisions: 10,
        ),
        const Divider(height: 28),

        // Renkli Chip'ler
        Text('Chip\'ler', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: const Text('Chip'), avatar: const Icon(Icons.label, size: 16)),
            ActionChip(label: const Text('Action'), onPressed: () {}),
            FilterChip(label: const Text('Filter'), selected: true, onSelected: (_) {}),
            InputChip(label: const Text('Input'), onDeleted: () {}),
          ],
        ),
        const Divider(height: 28),

        // Kart varyantları
        Text('Kartlar', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // Elevated Card (varsayılan)
        Card(
          child: ListTile(
            leading: Icon(Icons.layers, color: cs.primary),
            title: const Text('Elevated Card'),
            subtitle: const Text('Varsayılan kart türü'),
          ),
        ),
        // Filled Card
        Card(
          color: cs.surfaceContainerHighest,
          elevation: 0,
          child: ListTile(
            leading: Icon(Icons.layers_clear, color: cs.primary),
            title: const Text('Filled Card'),
            subtitle: const Text('Dolgulu, gölgesiz kart'),
          ),
        ),
        // Outlined Card
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: cs.outline),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.border_outer, color: cs.primary),
            title: const Text('Outlined Card'),
            subtitle: const Text('Kenarlıklı kart'),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── 4. Marka Kiti Sayfası ─────────────────────────────────────────

class _MarkaKitiSayfasi extends StatelessWidget {
  const _MarkaKitiSayfasi();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Logo alanı
        Card(
          color: cs.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Icon(Icons.flutter_dash, size: 72, color: cs.primary),
                const SizedBox(height: 12),
                Text(
                  'FlutterEğitim',
                  style: tt.headlineMedium?.copyWith(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sıfırdan Senior Flutter',
                  style: tt.bodyMedium?.copyWith(color: cs.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Birincil renkler
        Text('Renk Paleti', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _RenkKutusu('Primary', cs.primary, cs.onPrimary),
            _RenkKutusu('Secondary', cs.secondary, cs.onSecondary),
            _RenkKutusu('Tertiary', cs.tertiary, cs.onTertiary),
          ],
        ),
        const SizedBox(height: 20),

        // Tipografi örneği
        Text('Tipografi', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Başlık — headlineMedium', style: tt.headlineMedium),
                const SizedBox(height: 6),
                Text('Alt Başlık — titleLarge', style: tt.titleLarge),
                const SizedBox(height: 6),
                Text(
                  'Bu bir gövde metnidir. Flutter ile güzel uygulamalar geliştirmek artık çok kolay.',
                  style: tt.bodyMedium,
                ),
                const SizedBox(height: 6),
                Text('Etiket — labelSmall', style: tt.labelSmall?.copyWith(color: cs.outline)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Aksiyon butonları
        Text('Butonlar', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.rocket_launch),
          label: const Text('Derse Başla'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
          label: const Text('Müfredatı İncele'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Yardımcı Widget'lar ───────────────────────────────────────────

class _RenkKutusu extends StatelessWidget {
  final String ad;
  final Color arka;
  final Color on;

  const _RenkKutusu(this.ad, this.arka, this.on);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 72,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: arka,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ad, style: TextStyle(color: on, fontSize: 11, fontWeight: FontWeight.w600)),
            Text(
              '#${arka.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
              style: TextStyle(color: on.withValues(alpha: 0.7), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
