# Ders 01 — Material Design Bileşenleri

## Bu Derste Neler Öğreneceğiz?
- Material Design nedir ve neden önemlidir?
- `Scaffold`, `AppBar`, `Drawer` bileşenleri
- Buton türleri: `ElevatedButton`, `OutlinedButton`, `TextButton`, `IconButton`, `FloatingActionButton`
- `Card`, `ListTile`, `Chip`
- `SnackBar`, `AlertDialog`, `BottomSheet`
- Material 3 (useMaterial3: true) ile modern görünüm

---

## 1. Material Design Nedir?

Google'ın geliştirdiği **tasarım dilidir**. Flutter, Material Design'ı yerleşik olarak destekler.

```
Material Design hiyerarşisi:
┌───────────────────────────────┐
│  MaterialApp                  │ ← Uygulamanın kökü
│  ├── ThemeData                │ ← Renk, font, stil
│  └── Scaffold                 │ ← Sayfa iskeleti
│      ├── AppBar               │ ← Üst çubuk
│      ├── Drawer               │ ← Sol menü
│      ├── body                 │ ← Ana içerik
│      ├── bottomNavigationBar  │ ← Alt menü
│      └── floatingActionButton │ ← Yüzen buton
└───────────────────────────────┘
```

---

## 2. Scaffold ve AppBar

`Scaffold`, bir Material sayfasının iskeletidir:

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Başlık'),
    leading: const Icon(Icons.menu),       // Sol ikon
    actions: [                             // Sağ ikonlar
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      ),
    ],
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    elevation: 4,                          // Gölge yüksekliği
  ),
  body: const Center(child: Text('İçerik')),
)
```

### AppBar varyantları:

```dart
// SliverAppBar (kaydırmada küçülen/büyüyen AppBar)
CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,           // Kaydırınca küçülür ama kaybolmaz
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Başlık'),
        background: Image.network(url, fit: BoxFit.cover),
      ),
    ),
    // ... diğer sliver widget'lar
  ],
)
```

---

## 3. Drawer — Yan Menü

```dart
Scaffold(
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // Üst başlık bölümü
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.indigo),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(radius: 30, backgroundColor: Colors.white),
              SizedBox(height: 12),
              Text('Ali Veli', style: TextStyle(color: Colors.white, fontSize: 18)),
              Text('ali@email.com', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        // Menü öğeleri
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Ana Sayfa'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Ayarlar'),
          onTap: () {},
        ),
      ],
    ),
  ),
  body: const Center(child: Text('İçerik')),
)
```

---

## 4. Buton Türleri

Flutter'da 5 temel buton türü vardır:

```
Buton türleri görsel karşılaştırma:
┌─────────────────────────────────────────┐
│  [  ElevatedButton  ]   ← Dolgulu, gölgeli  │
│  ┌─ OutlinedButton ─┐   ← Kenarlıklı         │
│  TextButton           ← Düz yazı             │
│  (•)  IconButton      ← Sadece ikon          │
│  ⊕    FAB            ← Yüzen, belirgin       │
└─────────────────────────────────────────┘
```

### ElevatedButton (Yükseltilmiş Buton)

```dart
ElevatedButton(
  onPressed: () {
    print('Tıklandı!');
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: const Text('Kaydet'),
)

// İkonlu
ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.save),
  label: const Text('Kaydet'),
)
```

### OutlinedButton (Kenarlıklı Buton)

```dart
OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.indigo, width: 2),
  ),
  child: const Text('İptal'),
)
```

### TextButton (Düz Buton)

```dart
TextButton(
  onPressed: () {},
  child: const Text('Daha Fazla Göster'),
)
```

### IconButton (Ikon Butonu)

```dart
IconButton(
  icon: const Icon(Icons.favorite),
  color: Colors.red,
  tooltip: 'Beğen',            // Uzun basınca açıklama
  onPressed: () {},
)
```

### FloatingActionButton (FAB)

```dart
// Normal FAB
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
)

// Geniş FAB (etiketli)
FloatingActionButton.extended(
  onPressed: () {},
  icon: const Icon(Icons.add),
  label: const Text('Yeni Ekle'),
)

// Küçük FAB
FloatingActionButton.small(
  onPressed: () {},
  child: const Icon(Icons.edit),
)
```

---

## 5. Card (Kart)

Yüzey üzerinde yükselen içerik kutusu:

```dart
Card(
  elevation: 4,                // Gölge yüksekliği
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kart Başlığı',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Kart açıklama metni burada yer alır.'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: const Text('İptal')),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: () {}, child: const Text('Tamam')),
          ],
        ),
      ],
    ),
  ),
)
```

### ListTile ile Card

```dart
Card(
  child: ListTile(
    leading: const CircleAvatar(
      backgroundColor: Colors.indigoAccent,
      child: Icon(Icons.person, color: Colors.white),
    ),
    title: const Text('Ali Veli'),
    subtitle: const Text('Flutter Geliştirici'),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {},
  ),
)
```

---

## 6. Chip

Küçük, etiket benzeri bileşenler:

```dart
// Temel Chip
Chip(
  avatar: const Icon(Icons.tag, size: 16),
  label: const Text('Flutter'),
  backgroundColor: Colors.indigo.shade50,
)

// Silinebilir Chip
Chip(
  label: const Text('Dart'),
  onDeleted: () {
    // Chip kaldırıldı
  },
)

// Seçilebilir Chip
FilterChip(
  label: const Text('Favoriler'),
  selected: _secili,
  onSelected: (value) => setState(() => _secili = value),
)

// Tıklanabilir Chip
ActionChip(
  label: const Text('Paylaş'),
  onPressed: () {},
)
```

---

## 7. SnackBar (Alt Bildirim Çubuğu)

```dart
// Temel SnackBar
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Kaydedildi!'),
  ),
);

// Eylemli SnackBar
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Öğe silindi'),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade700,
    action: SnackBarAction(
      label: 'GERİ AL',
      textColor: Colors.white,
      onPressed: () {
        // Geri alma işlemi
      },
    ),
  ),
);
```

---

## 8. Dialog (Diyalog)

### AlertDialog

```dart
showDialog(
  context: context,
  builder: (ctx) => AlertDialog(
    title: const Text('Emin misiniz?'),
    content: const Text('Bu işlem geri alınamaz.'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(ctx),
        child: const Text('İptal'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(ctx);
          // İşlemi gerçekleştir
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text('Sil', style: TextStyle(color: Colors.white)),
      ),
    ],
  ),
);
```

### SimpleDialog (Seçenek Listesi)

```dart
showDialog(
  context: context,
  builder: (ctx) => SimpleDialog(
    title: const Text('Sıralama'),
    children: [
      SimpleDialogOption(
        onPressed: () => Navigator.pop(ctx, 'isim'),
        child: const Text('Ada Göre'),
      ),
      SimpleDialogOption(
        onPressed: () => Navigator.pop(ctx, 'tarih'),
        child: const Text('Tarihe Göre'),
      ),
    ],
  ),
);
```

---

## 9. BottomSheet (Alt Sayfa)

```dart
// Modal BottomSheet (sayfanın üstünde açılır)
showModalBottomSheet(
  context: context,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  builder: (ctx) => Container(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40, height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Seçenekler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('Paylaş'),
          onTap: () => Navigator.pop(ctx),
        ),
        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text('Sil', style: TextStyle(color: Colors.red)),
          onTap: () => Navigator.pop(ctx),
        ),
      ],
    ),
  ),
);
```

---

## 10. Material 3 — Modern Tasarım

Flutter 3.x ile gelen Material 3 özelliklerini aktif etmek:

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,                    // M3 aktif
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,           // Ana renk
    ),
  ),
)
```

Material 3 ile bileşenler otomatik olarak daha yuvarlak, modern görünüm kazanır.

---

## Bileşen Özeti

| Bileşen | Kullanım |
|---------|----------|
| `AppBar` | Sayfa başlığı ve aksiyonlar |
| `Drawer` | Yan kaydırma menüsü |
| `ElevatedButton` | Ana aksiyon butonu |
| `OutlinedButton` | İkincil aksiyon |
| `TextButton` | Düşük öncelikli aksiyon |
| `FloatingActionButton` | En önemli aksiyon |
| `Card` | İçerik kutusu |
| `ListTile` | Liste öğesi |
| `Chip` | Etiket / filtre |
| `SnackBar` | Kısa bildirim |
| `AlertDialog` | Onay/uyarı diyaloğu |
| `BottomSheet` | Alt sayfa paneli |

---

## Alıştırmalar

1. Bir `Scaffold` oluşturun: AppBar'da başlık + iki `IconButton`, sağda `Drawer` menü, ortada `Card` içinde `ListTile` listesi.
2. Bir silme butonu (`ElevatedButton`, kırmızı) yapın. Tıklanınca `AlertDialog` açsın, "Sil" butonuna basınca `SnackBar` göstersin.
3. Birden fazla `FilterChip` kullanarak filtre seçim alanı oluşturun (örn. "Flutter", "Dart", "Firebase" — seçilenler vurgulanır).
4. `showModalBottomSheet` ile paylaşma/düzenleme/silme seçeneklerini gösteren bir alt panel açın.

---

**Önceki Modül:** [Modül 2 — Flutter Temelleri](../../Modul2_Flutter_Temelleri/)
**Sonraki Ders:** [Ders 02 — Formlar ve Input](../Ders02_Formlar_ve_Input/ders_notu.md)
