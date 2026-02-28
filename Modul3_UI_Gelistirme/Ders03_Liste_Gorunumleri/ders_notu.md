# Ders 03 — Liste Görünümleri

## Bu Derste Neler Öğreneceğiz?
- `ListView` — kaydırılabilir liste
- `ListView.builder` — performanslı liste oluşturma
- `ListView.separated` — ayraçlı liste
- `GridView` ve `GridView.builder` — ızgara görünüm
- `ListTile` ve özel liste öğeleri
- Kaydırma kontrolü (`ScrollController`)
- Kaydırma yönü (yatay/dikey)
- `ReorderableListView` — sürükle-bırak sıralama
- `Slivers` ve `CustomScrollView`

---

## 1. ListView — Temel Liste

### Sabit eleman sayısı için

```dart
ListView(
  children: [
    ListTile(title: const Text('Öğe 1')),
    ListTile(title: const Text('Öğe 2')),
    ListTile(title: const Text('Öğe 3')),
  ],
)
```

> **Dikkat:** `ListView` tüm çocukları aynı anda oluşturur. Az sayıda öğe için uygundur.

---

## 2. ListView.builder — Performanslı Liste

Binlerce öğe için `ListView.builder` kullanın. Yalnızca ekranda görünen öğeleri oluşturur:

```dart
ListView.builder(
  itemCount: urunler.length,
  itemBuilder: (context, index) {
    final urun = urunler[index];
    return ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text(urun.ad),
      subtitle: Text('₺${urun.fiyat}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        print('${urun.ad} seçildi');
      },
    );
  },
)
```

### Önemli parametreler:

| Parametre | Açıklama |
|-----------|----------|
| `itemCount` | Toplam öğe sayısı |
| `itemBuilder` | Her öğe için widget döndüren fonksiyon |
| `scrollDirection` | `Axis.vertical` (varsayılan) veya `Axis.horizontal` |
| `reverse` | Listeyi ters sırada göster |
| `padding` | Liste etrafındaki boşluk |
| `physics` | Kaydırma davranışı |

---

## 3. ListView.separated — Ayraçlı Liste

Öğeler arasına otomatik ayraç ekler:

```dart
ListView.separated(
  itemCount: liste.length,
  separatorBuilder: (context, index) => const Divider(height: 1),
  itemBuilder: (context, index) {
    return ListTile(title: Text(liste[index]));
  },
)
```

---

## 4. Yatay Liste

```dart
SizedBox(
  height: 120,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,      // Yatay kaydırma
    itemCount: kategoriler.length,
    itemBuilder: (context, index) {
      return Container(
        width: 100,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(kategoriler[index])),
      );
    },
  ),
)
```

---

## 5. GridView — Izgara Görünüm

### GridView.count — Sabit sütun sayısı

```dart
GridView.count(
  crossAxisCount: 2,               // Sütun sayısı
  crossAxisSpacing: 8,             // Yatay boşluk
  mainAxisSpacing: 8,              // Dikey boşluk
  childAspectRatio: 1.2,           // En/boy oranı
  padding: const EdgeInsets.all(8),
  children: List.generate(12, (index) {
    return Card(
      child: Center(child: Text('Öğe $index')),
    );
  }),
)
```

### GridView.builder — Performanslı ızgara

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 0.75,       // Boyuna dikdörtgen
  ),
  itemCount: urunler.length,
  itemBuilder: (context, index) {
    final urun = urunler[index];
    return _UrunKarti(urun: urun);
  },
)
```

### Dinamik sütun genişliği

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,       // Max genişlik
    childAspectRatio: 1,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 20,
  itemBuilder: (context, index) => /* ... */,
)
```

---

## 6. ScrollController — Kaydırma Kontrolü

```dart
class _ListeSayfasiState extends State<ListeSayfasi> {
  final _scrollController = ScrollController();
  bool _usteBas = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // 200px aşıldığında butonu göster
      final goster = _scrollController.offset > 200;
      if (goster != _usteBas) {
        setState(() => _usteBas = goster);
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
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (context, index) => ListTile(title: Text('Öğe $index')),
      ),
      floatingActionButton: _usteBas
          ? FloatingActionButton(
              onPressed: _basa_don,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
```

---

## 7. RefreshIndicator — Yenile

```dart
RefreshIndicator(
  onRefresh: () async {
    // Verileri yenile
    await _verileriYukle();
  },
  child: ListView.builder(
    itemCount: liste.length,
    itemBuilder: (context, index) => ListTile(title: Text(liste[index])),
  ),
)
```

---

## 8. Slivers ve CustomScrollView

Farklı kaydırma davranışlarını tek akışta birleştirmek için:

```dart
CustomScrollView(
  slivers: [
    // Kapanan AppBar
    SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Ürünler'),
        background: Container(color: Colors.indigo),
      ),
    ),

    // Liste başlığı
    const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Öne Çıkanlar', style: TextStyle(fontSize: 18)),
      ),
    ),

    // Yatay kaydırmalı öne çıkan ürünler
    SliverToBoxAdapter(
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => /* kart */,
        ),
      ),
    ),

    // Tüm ürünler ızgarası
    SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => /* kart */,
        childCount: 20,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
    ),
  ],
)
```

---

## 9. ReorderableListView — Sürükle-Bırak

```dart
ReorderableListView(
  onReorder: (eskiIndex, yeniIndex) {
    setState(() {
      if (yeniIndex > eskiIndex) yeniIndex--;
      final ogedir = liste.removeAt(eskiIndex);
      liste.insert(yeniIndex, ogedir);
    });
  },
  children: liste.map((ogedir) {
    return ListTile(
      key: ValueKey(ogedir),
      title: Text(ogedir),
      trailing: const Icon(Icons.drag_handle),
    );
  }).toList(),
)
```

---

## Liste Görünümleri Özeti

```
Liste türleri:
├── ListView              → Az sayıda sabit öğe
├── ListView.builder     → Büyük/dinamik listeler (performanslı)
├── ListView.separated   → Ayraçlı listeler
│
├── GridView.count       → Sabit sütunlu ızgara
├── GridView.builder     → Büyük ızgara listeleri
│
├── CustomScrollView     → Karışık kaydırma davranışları
│   └── Slivers          → SliverList, SliverGrid, SliverAppBar
│
└── ReorderableListView  → Sürükle-bırak sıralama
```

---

## Alıştırmalar

1. 50 öğelik bir yapılacaklar listesi yapın. `ListView.builder` kullanın. Her öğede checkbox olsun, tıklanınca üstü çizilsin.
2. `GridView.builder` ile 20 ürünlü bir ürün kataloğu yapın. Her kart: resim yerine renkli ikon, ürün adı, fiyat içersin.
3. `ScrollController` ekleyin: Liste 300px aşağı kaydırılınca FAB görünsün, tıklayınca liste başına animasyonla dönsün.
4. `CustomScrollView` + `SliverAppBar` + `SliverGrid` kullanarak küçülen başlıklı bir ürün kataloğu yapın.

---

**Önceki Ders:** [Ders 02 — Formlar ve Input](../Ders02_Formlar_ve_Input/ders_notu.md)
**Sonraki Ders:** [Ders 04 — Tema ve Stil](../Ders04_Tema_ve_Stil/ders_notu.md)
