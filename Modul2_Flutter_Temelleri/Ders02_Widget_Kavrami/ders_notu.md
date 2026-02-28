# Ders 02 — Widget Kavramı

## Bu Derste Neler Öğreneceğiz?
- Flutter'da her şey bir widget'tır
- Widget ağacı (Widget Tree)
- `StatelessWidget` — değişmeyen widget'lar
- Temel görsel widget'lar: `Text`, `Icon`, `Image`, `Container`, `ElevatedButton`
- `Scaffold` — ekran iskeleti
- `Theme` ile stil

---

## 1. Flutter'da Her Şey Bir Widget'tır

Flutter'da ekranda gördüğünüz **her şey** bir widget'tır:

```
┌──────────────────────────────────────────┐
│  Scaffold                                │
│  ├── AppBar                              │
│  │   └── Text("Başlık")                 │
│  └── body                               │
│      └── Center                         │
│          └── Column                     │
│              ├── Text("Merhaba")        │
│              ├── Icon(Icons.star)        │
│              └── ElevatedButton(...)    │
└──────────────────────────────────────────┘
```

Widget'lar ağaç (tree) yapısında birbirinin içine yerleşir. Buna **Widget Tree** denir.

---

## 2. StatelessWidget — Değişmeyen Widget

Oluşturulduktan sonra içeriği değişmeyen widget'lar için kullanılır.

```dart
class SelamlamaKarti extends StatelessWidget {
  final String isim;
  final int yas;

  const SelamlamaKarti({
    super.key,
    required this.isim,
    required this.yas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Merhaba, $isim!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('$yas yaşındasın'),
        ],
      ),
    );
  }
}
```

**Kurallar:**
- `StatelessWidget` extends edilir
- `build()` metodu `override` edilir
- `build()` her zaman bir `Widget` döndürür
- Constructor'da `const` ve `super.key` kullanılır

---

## 3. Temel Widget'lar

### Text — Metin Gösterme

```dart
// Basit metin
Text('Merhaba Flutter')

// Stillendirilmiş
Text(
  'Başlık',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.5,
    decoration: TextDecoration.underline,
  ),
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis, // Taşarsa ... göster
)

// Theme'den gelen stil
Text(
  'Başlık',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

### Icon — İkon Gösterme

```dart
// Material ikonları
Icon(Icons.home)
Icon(Icons.favorite, color: Colors.red, size: 48)
Icon(Icons.star, color: Colors.amber)
Icon(Icons.person, semanticLabel: 'Kullanıcı profili')

// Tüm ikonlar: https://fonts.google.com/icons
```

### Image — Görsel Gösterme

```dart
// Ağdan resim (URL)
Image.network('https://picsum.photos/200/300')

// Asset'ten (projedeki resim)
// pubspec.yaml'a ekle: assets: - assets/images/
Image.asset('assets/images/logo.png')

// Boyutlandırma
Image.network(
  'https://picsum.photos/200',
  width: 200,
  height: 200,
  fit: BoxFit.cover,    // cover, contain, fill, fitWidth, fitHeight
)

// Hata durumu
Image.network(
  url,
  errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image),
)
```

### ElevatedButton — Yüksek Buton

```dart
ElevatedButton(
  onPressed: () {
    print("Butona basıldı!");
  },
  child: const Text('Tıkla'),
)

// Stillendirilmiş
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: const Text('Gönder', style: TextStyle(fontSize: 18)),
)

// Devre dışı buton
ElevatedButton(
  onPressed: null, // null → devre dışı
  child: const Text('Devre Dışı'),
)
```

### Diğer Buton Türleri

```dart
// Düz metin buton
TextButton(onPressed: () {}, child: const Text('İptal'))

// Çerçeveli buton
OutlinedButton(onPressed: () {}, child: const Text('Daha fazla'))

// İkon buton
IconButton(icon: const Icon(Icons.favorite), onPressed: () {})

// FAB (Floating Action Button)
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
)
```

---

## 4. Container — Çok Amaçlı Kutu

`Container`, kutu oluşturmak için kullanılan çok yönlü bir widget'tır:

```dart
Container(
  width: 200,
  height: 100,
  margin: const EdgeInsets.all(16),        // Dış boşluk
  padding: const EdgeInsets.symmetric(     // İç boşluk
    horizontal: 24,
    vertical: 12,
  ),
  decoration: BoxDecoration(
    color: Colors.blue,                    // Arka plan rengi
    borderRadius: BorderRadius.circular(12), // Köşe yuvarlama
    border: Border.all(                    // Kenar çizgisi
      color: Colors.black,
      width: 2,
    ),
    boxShadow: [                           // Gölge
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
    gradient: LinearGradient(             // Degrade
      colors: [Colors.blue, Colors.purple],
    ),
  ),
  child: const Text('İçerik'),
)
```

### EdgeInsets Kısayolları

```dart
EdgeInsets.all(16)                      // 4 taraf eşit
EdgeInsets.symmetric(horizontal: 16)    // Yatay eşit
EdgeInsets.symmetric(vertical: 8)       // Dikey eşit
EdgeInsets.only(left: 16, top: 8)       // Seçili taraflar
EdgeInsets.fromLTRB(16, 8, 16, 8)       // Sol,Üst,Sağ,Alt
```

---

## 5. Scaffold — Ekran İskeleti

`Scaffold`, bir ekranın standart yapısını sağlar:

```dart
Scaffold(
  // Üst çubuk
  appBar: AppBar(
    title: const Text('Başlık'),
    leading: const Icon(Icons.menu),     // Sol ikon
    actions: [                           // Sağ ikonlar
      IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
    ],
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    elevation: 4,
  ),

  // İçerik
  body: const Center(child: Text('İçerik buraya')),

  // Alt navigasyon çubuğu (opsiyonel)
  bottomNavigationBar: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
    ],
  ),

  // Yüzen buton
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),

  // Drawer (yan menü)
  drawer: Drawer(child: ListView(/* menü öğeleri */)),
)
```

---

## 6. Sık Kullanılan Yardımcı Widget'lar

```dart
// Boşluk bırakma
SizedBox(height: 16)           // Dikey boşluk
SizedBox(width: 8)             // Yatay boşluk
SizedBox(height: 200, child: widget) // Sabit boyut

// İç boşluk (padding)
Padding(
  padding: const EdgeInsets.all(16),
  child: Text('İçerik'),
)

// Ortaya hizalama
Center(child: Text('Ortada'))

// Tam genişlik/yükseklik
Expanded(child: Container(color: Colors.blue))

// Çerçeve
DecoratedBox(
  decoration: BoxDecoration(border: Border.all()),
  child: Text('çerçeveli'),
)

// Dairesel clip
ClipRRect(
  borderRadius: BorderRadius.circular(50),
  child: Image.network(url, width: 100, height: 100),
)

// SafeArea (notch/navigasyon bar'ın arkasına gizlenmeyi önler)
SafeArea(child: content)
```

---

## 7. Renk Kullanımı

```dart
// Material renkleri
Colors.red
Colors.blue.shade200
Colors.green.shade700

// Özel renk (hex)
Color(0xFF6750A4)
Color.fromRGBO(103, 80, 164, 1.0)  // R, G, B, Opacity

// Şeffaflık
Colors.black.withOpacity(0.5)
Colors.blue.withAlpha(128)

// Tema renkleri (önerilir)
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface
Theme.of(context).colorScheme.onPrimary
```

---

## 8. Widget'ı Parçalara Ayırma (Composition)

Büyük `build()` metodları okunması zor hale gelir. Widget'ları küçük parçalara bölün:

```dart
class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _profilBasligi(),
          _istatistikler(),
          _sosyalButonlar(),
        ],
      ),
    );
  }

  Widget _profilBasligi() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 8),
          const Text('Ahmet Yılmaz', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _istatistikler() { /* ... */ return const SizedBox(); }
  Widget _sosyalButonlar() { /* ... */ return const SizedBox(); }
}
```

---

## Özet

```
Widget hiyerarşisi:
MaterialApp
    └── Scaffold
            ├── AppBar
            │     └── Text, IconButton...
            ├── body
            │     └── herhangi bir widget
            ├── floatingActionButton
            └── bottomNavigationBar

Temel widget'lar:
├── Text         → Metin göster
├── Icon         → İkon göster
├── Image        → Resim göster
├── Container    → Kutu, arka plan, padding
├── SizedBox     → Sabit boyut / boşluk
├── Padding      → İç boşluk
├── Center       → Ortaya hizala
├── ElevatedButton → Buton
└── Scaffold     → Ekran iskeleti
```

---

## Alıştırmalar

> Tüm örnekleri [Ders01'deki](../Ders01_Kurulum_ve_Proje_Yapisi/ders_notu.md) minimal şablonu kullanarak `main.dart`'a yazın.

1. `AppBar`'da başlık ve arama ikonu olan bir ekran oluşturun.
2. Profil kartı widget'ı yapın: avatar ikonu, isim, meslek, "Takip Et" butonu.
3. Gradient (degrade) arka planlı, üzerinde beyaz metin olan bir `Container` oluşturun.
4. 3 farklı buton türünü (`Elevated`, `Text`, `Outlined`) yan yana gösterin.
5. Kendi adınızı, bir ikonu ve bir butonu içeren tam bir ekran oluşturun.

---

**Önceki Ders:** [Ders 01 — Kurulum ve Proje Yapısı](../Ders01_Kurulum_ve_Proje_Yapisi/ders_notu.md)
**Sonraki Ders:** [Ders 03 — Layout Widget'ları](../Ders03_Layout_Widgetlari/ders_notu.md)
