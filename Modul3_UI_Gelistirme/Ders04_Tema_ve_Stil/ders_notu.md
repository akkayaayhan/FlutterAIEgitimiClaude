# Ders 04 — Tema ve Stil

## Bu Derste Neler Öğreneceğiz?
- `ThemeData` ile uygulama geneli tema tanımlama
- `ColorScheme` ve `ColorScheme.fromSeed`
- Açık/koyu tema (light/dark mode) desteği
- `Theme.of(context)` ile temaya erişim
- `TextTheme` ve tipografi
- Bileşen bazlı tema geçersiz kılma (`copyWith`)
- Özel renkler ve `Color` sınıfı
- `TextStyle` parametreleri
- Tema değişikliği (runtime'da tema değiştirme)

---

## 1. ThemeData — Temel Tema

`MaterialApp` içinde tek seferinde tanımlanır, tüm uygulamada geçerli olur:

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,

    // Renk şeması — tek renkten tüm paleti üret
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,   // Açık tema
    ),

    // Tipografi
    fontFamily: 'Roboto',

    // Bileşen temaları
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
  ),
  home: const AnaSayfa(),
)
```

---

## 2. Açık ve Koyu Tema

```dart
MaterialApp(
  // Açık tema
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ),

  // Koyu tema
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),

  // Hangisini kullan?
  themeMode: ThemeMode.system,   // Cihaz ayarını takip et
  // themeMode: ThemeMode.light, // Her zaman açık
  // themeMode: ThemeMode.dark,  // Her zaman koyu
)
```

### Runtime'da tema değiştirme

```dart
// Durum tutacak değişken
ThemeMode _temaMode = ThemeMode.system;

// MaterialApp'te bağla
MaterialApp(
  themeMode: _temaMode,
  // ...
)

// Butona basınca değiştir
void _temaToggle() {
  setState(() {
    _temaMode = _temaMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  });
}
```

---

## 3. ColorScheme — Renk Paleti

Material 3, tek bir `seedColor`'dan 30+ renk üretir:

```
ColorScheme yapısı (Material 3):
┌─────────────────────────────────────────┐
│  primary        → Ana aksiyon rengi     │
│  onPrimary      → Primary üstündeki     │
│  primaryContainer → Hafif ton           │
│  onPrimaryContainer → Metin rengi       │
│                                         │
│  secondary      → İkincil renk          │
│  tertiary       → Üçüncü vurgu          │
│                                         │
│  surface        → Kart/arka plan        │
│  onSurface      → Kart üstü metin       │
│                                         │
│  error          → Hata rengi (kırmızı)  │
│  outline        → Kenarlık rengi        │
└─────────────────────────────────────────┘
```

```dart
// Tema renklerine erişim
final renk = Theme.of(context).colorScheme;

Container(
  color: renk.primaryContainer,
  child: Text(
    'Metin',
    style: TextStyle(color: renk.onPrimaryContainer),
  ),
)
```

---

## 4. Theme.of(context) — Temaya Erişim

Widget içinden mevcut temaya erişmek için:

```dart
@override
Widget build(BuildContext context) {
  // Tema nesneleri
  final tema = Theme.of(context);
  final renkSemasi = tema.colorScheme;
  final yazıTeması = tema.textTheme;

  return Column(
    children: [
      // Renk şemasından renkler
      Container(
        color: renkSemasi.primary,
        child: Text(
          'Ana Renk',
          style: TextStyle(color: renkSemasi.onPrimary),
        ),
      ),

      // Text theme'den yazı stilleri
      Text('Büyük Başlık', style: yazıTeması.headlineLarge),
      Text('Orta Başlık', style: yazıTeması.titleMedium),
      Text('Normal Metin', style: yazıTeması.bodyMedium),
      Text('Küçük Etiket', style: yazıTeması.labelSmall),
    ],
  );
}
```

---

## 5. TextTheme — Tipografi

Material 3'ün standart yazı stilleri:

```
TextTheme hiyerarşisi:
┌───────────────────────────────────────────────────┐
│  displayLarge    → 57sp  Çok büyük başlık         │
│  displayMedium   → 45sp  Büyük başlık             │
│  displaySmall    → 36sp  Orta büyük başlık        │
│                                                   │
│  headlineLarge   → 32sp  Sayfa başlığı            │
│  headlineMedium  → 28sp  Bölüm başlığı            │
│  headlineSmall   → 24sp  Alt bölüm                │
│                                                   │
│  titleLarge      → 22sp  Önemli başlık            │
│  titleMedium     → 16sp  Kart başlığı             │
│  titleSmall      → 14sp  Küçük başlık             │
│                                                   │
│  bodyLarge       → 16sp  Uzun metin               │
│  bodyMedium      → 14sp  Normal metin             │
│  bodySmall       → 12sp  Küçük metin              │
│                                                   │
│  labelLarge      → 14sp  Buton metni              │
│  labelMedium     → 12sp  Etiket                   │
│  labelSmall      → 11sp  Küçük etiket             │
└───────────────────────────────────────────────────┘
```

```dart
// Özel font ailesi tanımlama
ThemeData(
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      height: 1.5,   // Satır yüksekliği
    ),
  ),
)
```

---

## 6. TextStyle — Metin Stili

```dart
Text(
  'Merhaba Dünya',
  style: TextStyle(
    fontSize: 18,                     // Boyut
    fontWeight: FontWeight.w700,      // Kalınlık (w100-w900)
    fontStyle: FontStyle.italic,      // Yatık
    color: Colors.indigo,             // Renk
    letterSpacing: 1.5,               // Harf aralığı
    wordSpacing: 4,                   // Kelime aralığı
    height: 1.5,                      // Satır yüksekliği (katı)
    decoration: TextDecoration.underline,  // Altı çizili
    decorationColor: Colors.red,      // Çizgi rengi
    shadows: [
      Shadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: const Offset(2, 2),
      ),
    ],
  ),
)
```

### Tema stilini genişletme:

```dart
// Tema stilini al ve değiştir
Text(
  'Başlık',
  style: Theme.of(context).textTheme.titleLarge?.copyWith(
    color: Colors.red,
    fontWeight: FontWeight.w900,
  ),
)
```

---

## 7. Bileşen Teması — copyWith

Mevcut temayı küçük değişikliklerle geçersiz kılmak:

```dart
// Uygulama geneli tema
ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
  ),
)

// Tek buton için geçersiz kıl
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,   // Sadece bu buton kırmızı
  ),
  onPressed: () {},
  child: const Text('Sil'),
)
```

---

## 8. Custom Colors — Özel Renkler

```dart
// Hex renk kodu
const Color lacivert = Color(0xFF1A237E);
const Color acikMavi = Color(0xFFE3F2FD);

// HSL ile
final hsl = HSLColor.fromAHSL(1.0, 210, 0.8, 0.4);
final renk = hsl.toColor();

// Opaklık
Colors.indigo.withOpacity(0.5)     // %50 saydam
Colors.indigo.withAlpha(128)        // 0-255 alfa

// Renk tonu elde etme
Colors.blue.shade100   // Çok açık mavi
Colors.blue.shade900   // Çok koyu mavi
```

---

## 9. Tema Mirasını Yerel Olarak Değiştirme

`Theme` widget'ı ile belirli bir alt ağaçta farklı tema:

```dart
// Bu widget ve altındakiler kırmızı tema kullanır
Theme(
  data: Theme.of(context).copyWith(
    colorScheme: Theme.of(context).colorScheme.copyWith(
      primary: Colors.red,
    ),
  ),
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Kırmızı Buton'),
  ),
)
```

---

## Tema Özeti

| Konu | Kullanım |
|------|----------|
| `ThemeData` | Uygulama geneli tema |
| `ColorScheme.fromSeed` | Tek renkten palet üret |
| `ThemeMode.dark` | Koyu tema |
| `Theme.of(context)` | Widget içinden temaya eriş |
| `textTheme.titleLarge` | Standart yazı stilleri |
| `copyWith` | Temayı kısmen değiştir |
| `Color(0xFF...)` | Hex renk kodu |

---

## Alıştırmalar

1. Favori renginizle `ColorScheme.fromSeed` kullanarak tema oluşturun. `AppBar`, `Card`, buton renklerini otomatik uyumlu hale getirin.
2. Uygulama genelinde açık/koyu tema destekleyin. Sağ üst köşedeki ikonla toggle yapın.
3. `TextTheme`'i kullanarak tipografi sergileme sayfası yapın: `displayLarge`'tan `labelSmall`'a tüm stilleri listeleyin.
4. Bir "Marka Kiti" sayfası yapın: şirketinizin birincil ve ikincil renklerini, font stillerini gösteren bir widget galerisi.

---

**Önceki Ders:** [Ders 03 — Liste Görünümleri](../Ders03_Liste_Gorunumleri/ders_notu.md)
**Sonraki Ders:** [Ders 05 — Responsive Tasarım](../Ders05_Responsive_Tasarim/ders_notu.md)
