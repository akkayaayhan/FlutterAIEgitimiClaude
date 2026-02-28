// Ders 03 — Liste Görünümleri: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run

import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste Görünümleri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const AnaSayfa(),
    );
  }
}

// ── Veri Modeli ───────────────────────────────────────────────────

class Urun {
  final int id;
  final String ad;
  final double fiyat;
  final String kategori;
  final Color renk;
  final IconData ikon;

  const Urun({
    required this.id,
    required this.ad,
    required this.fiyat,
    required this.kategori,
    required this.renk,
    required this.ikon,
  });
}

final List<Urun> tumUrunler = [
  const Urun(id: 1, ad: 'Flutter Kitabı', fiyat: 149.90, kategori: 'Eğitim', renk: Colors.blue, ikon: Icons.book),
  const Urun(id: 2, ad: 'Dart Kursu', fiyat: 299.00, kategori: 'Eğitim', renk: Colors.orange, ikon: Icons.play_circle),
  const Urun(id: 3, ad: 'VS Code Teması', fiyat: 49.90, kategori: 'Araç', renk: Colors.purple, ikon: Icons.palette),
  const Urun(id: 4, ad: 'Firebase Paketi', fiyat: 199.00, kategori: 'Backend', renk: Colors.red, ikon: Icons.cloud),
  const Urun(id: 5, ad: 'UI Kit', fiyat: 89.90, kategori: 'Tasarım', renk: Colors.green, ikon: Icons.design_services),
  const Urun(id: 6, ad: 'API Rehberi', fiyat: 129.00, kategori: 'Eğitim', renk: Colors.indigo, ikon: Icons.api),
  const Urun(id: 7, ad: 'Test Şablonu', fiyat: 79.90, kategori: 'Araç', renk: Colors.brown, ikon: Icons.bug_report),
  const Urun(id: 8, ad: 'Git Kılavuzu', fiyat: 69.00, kategori: 'Araç', renk: Colors.cyan, ikon: Icons.source),
  const Urun(id: 9, ad: 'State Paketi', fiyat: 159.00, kategori: 'Eğitim', renk: Colors.pink, ikon: Icons.hub),
  const Urun(id: 10, ad: 'Animasyon Seti', fiyat: 219.00, kategori: 'Tasarım', renk: Colors.amber, ikon: Icons.animation),
  const Urun(id: 11, ad: 'Map Entegrasyonu', fiyat: 249.00, kategori: 'Backend', renk: Colors.lime, ikon: Icons.map),
  const Urun(id: 12, ad: 'Push Notification', fiyat: 189.00, kategori: 'Backend', renk: Colors.teal, ikon: Icons.notifications),
];

// ── Ana Sayfa ─────────────────────────────────────────────────────

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste Görünümleri'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Liste'),
            Tab(icon: Icon(Icons.grid_view), text: 'Izgara'),
            Tab(icon: Icon(Icons.checklist), text: 'Yapılacak'),
            Tab(icon: Icon(Icons.reorder), text: 'Sıralama'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UrunListeSayfasi(),
          UrunIzgaraSayfasi(),
          YapilacaklarSayfasi(),
          SiralamaSayfasi(),
        ],
      ),
    );
  }
}

// ── 1. Ürün Listesi (ListView.builder + ScrollController) ─────────

class UrunListeSayfasi extends StatefulWidget {
  const UrunListeSayfasi({super.key});

  @override
  State<UrunListeSayfasi> createState() => _UrunListeSayfasiState();
}

class _UrunListeSayfasiState extends State<UrunListeSayfasi> {
  final _scrollController = ScrollController();
  bool _usteButonGoster = false;
  String _aramaMetni = '';
  String? _seciliKategori;

  List<String> get _kategoriler =>
      ['Tümü', ...tumUrunler.map((u) => u.kategori).toSet().toList()];

  List<Urun> get _filtreliUrunler => tumUrunler.where((u) {
        final kategoriUygun = _seciliKategori == null || _seciliKategori == 'Tümü' || u.kategori == _seciliKategori;
        final aramaUygun = _aramaMetni.isEmpty || u.ad.toLowerCase().contains(_aramaMetni.toLowerCase());
        return kategoriUygun && aramaUygun;
      }).toList();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final goster = _scrollController.offset > 200;
      if (goster != _usteButonGoster) {
        setState(() => _usteButonGoster = goster);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _basaDon() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Arama alanı
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ürün ara...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  isDense: true,
                ),
                onChanged: (v) => setState(() => _aramaMetni = v),
              ),
            ),

            // Kategori filtreleri (yatay liste)
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _kategoriler.length,
                itemBuilder: (context, index) {
                  final kat = _kategoriler[index];
                  final secili = kat == (_seciliKategori ?? 'Tümü');
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(kat),
                      selected: secili,
                      onSelected: (_) => setState(() => _seciliKategori = kat),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // Ürün listesi
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Liste güncellendi')),
                  );
                },
                child: _filtreliUrunler.isEmpty
                    ? const Center(child: Text('Ürün bulunamadı'))
                    : ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: _filtreliUrunler.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final urun = _filtreliUrunler[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: urun.renk.withValues(alpha: 0.2),
                              child: Icon(urun.ikon, color: urun.renk),
                            ),
                            title: Text(
                              urun.ad,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(urun.kategori),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₺${urun.fiyat.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: urun.renk,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${urun.ad} seçildi')),
                              );
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        ),

        // Başa dön butonu
        if (_usteButonGoster)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: _basaDon,
              child: const Icon(Icons.arrow_upward),
            ),
          ),
      ],
    );
  }
}

// ── 2. Ürün Izgarası (GridView.builder + CustomScrollView) ────────

class UrunIzgaraSayfasi extends StatefulWidget {
  const UrunIzgaraSayfasi({super.key});

  @override
  State<UrunIzgaraSayfasi> createState() => _UrunIzgaraSayfasiState();
}

class _UrunIzgaraSayfasiState extends State<UrunIzgaraSayfasi> {
  int _sutunSayisi = 2;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Kapanan header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${tumUrunler.length} ürün',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                // Sütun sayısı değiştir
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.view_list),
                      onPressed: () => setState(() => _sutunSayisi = 1),
                      color: _sutunSayisi == 1 ? Colors.teal : Colors.grey,
                    ),
                    IconButton(
                      icon: const Icon(Icons.grid_view),
                      onPressed: () => setState(() => _sutunSayisi = 2),
                      color: _sutunSayisi == 2 ? Colors.teal : Colors.grey,
                    ),
                    IconButton(
                      icon: const Icon(Icons.grid_on),
                      onPressed: () => setState(() => _sutunSayisi = 3),
                      color: _sutunSayisi == 3 ? Colors.teal : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Ürün ızgarası
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final urun = tumUrunler[index];
                return _UrunGridKarti(urun: urun);
              },
              childCount: tumUrunler.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _sutunSayisi,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: _sutunSayisi == 1 ? 4 : 0.75,
            ),
          ),
        ),
      ],
    );
  }
}

class _UrunGridKarti extends StatelessWidget {
  final Urun urun;
  const _UrunGridKarti({required this.urun});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${urun.ad} sepete eklendi')),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ürün görseli (simüle)
            Expanded(
              child: Container(
                color: urun.renk.withValues(alpha: 0.15),
                child: Icon(urun.ikon, size: 40, color: urun.renk),
              ),
            ),
            // Bilgiler
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    urun.ad,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    urun.kategori,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₺${urun.fiyat.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: urun.renk,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 3. Yapılacaklar Listesi ───────────────────────────────────────

class YapilacaklarSayfasi extends StatefulWidget {
  const YapilacaklarSayfasi({super.key});

  @override
  State<YapilacaklarSayfasi> createState() => _YapilacaklarSayfasiState();
}

class Gorev {
  String baslik;
  bool tamamlandi;
  Gorev(this.baslik, {this.tamamlandi = false});
}

class _YapilacaklarSayfasiState extends State<YapilacaklarSayfasi> {
  final _controller = TextEditingController();
  final List<Gorev> _gorevler = [
    Gorev('Flutter öğren'),
    Gorev('Dart pratik yap', tamamlandi: true),
    Gorev('Uygulama yayınla'),
    Gorev('Portföy hazırla'),
  ];

  void _ekle() {
    final metin = _controller.text.trim();
    if (metin.isEmpty) return;
    setState(() {
      _gorevler.add(Gorev(metin));
      _controller.clear();
    });
  }

  void _sil(int index) {
    setState(() => _gorevler.removeAt(index));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tamamlanan = _gorevler.where((g) => g.tamamlandi).length;

    return Column(
      children: [
        // İlerleme
        LinearProgressIndicator(
          value: _gorevler.isEmpty ? 0 : tamamlanan / _gorevler.length,
          backgroundColor: Colors.grey.shade200,
          color: Colors.teal,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            '$tamamlanan / ${_gorevler.length} tamamlandı',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        // Yeni görev ekle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Yeni görev...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  onSubmitted: (_) => _ekle(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _ekle,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Görev listesi
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _gorevler.length,
            itemBuilder: (context, index) {
              final gorev = _gorevler[index];
              return Dismissible(
                key: ValueKey('${gorev.baslik}_$index'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => _sil(index),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: CheckboxListTile(
                    value: gorev.tamamlandi,
                    onChanged: (v) => setState(() => gorev.tamamlandi = v!),
                    title: Text(
                      gorev.baslik,
                      style: TextStyle(
                        decoration: gorev.tamamlandi ? TextDecoration.lineThrough : null,
                        color: gorev.tamamlandi ? Colors.grey : null,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.teal,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── 4. Sıralama (ReorderableListView) ────────────────────────────

class SiralamaSayfasi extends StatefulWidget {
  const SiralamaSayfasi({super.key});

  @override
  State<SiralamaSayfasi> createState() => _SiralamaSayfasiState();
}

class _SiralamaSayfasiState extends State<SiralamaSayfasi> {
  final List<String> _moduller = [
    'Modül 1 — Dart Temelleri',
    'Modül 2 — Flutter Temelleri',
    'Modül 3 — UI Geliştirme',
    'Modül 4 — State Management',
    'Modül 5 — API ve Async',
    'Modül 6 — Yerel Depolama',
    'Modül 7 — İleri Flutter',
    'Modül 8 — Mimari ve Senior',
    'Modül 9 — Bitirme Projesi',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Sürükleyerek sırayı değiştirin',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _moduller.length,
            onReorder: (eskiIndex, yeniIndex) {
              setState(() {
                if (yeniIndex > eskiIndex) yeniIndex--;
                final item = _moduller.removeAt(eskiIndex);
                _moduller.insert(yeniIndex, item);
              });
            },
            itemBuilder: (context, index) {
              return Card(
                key: ValueKey(_moduller[index]),
                margin: const EdgeInsets.only(bottom: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade100,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(_moduller[index]),
                  trailing: const Icon(Icons.drag_handle, color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
