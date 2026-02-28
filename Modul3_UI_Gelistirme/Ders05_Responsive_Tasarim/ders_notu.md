# Ders 05 — Responsive Tasarım

## Bu Derste Neler Öğreneceğiz?
- Responsive vs Adaptive tasarım farkı
- `MediaQuery` ile ekran boyutu okuma
- `LayoutBuilder` ile ebeveyn boyutuna göre düzen
- Kırılım noktaları (breakpoints) tanımlama
- `Flexible` ve `Expanded` widget'ları
- `Wrap` — taşan widget'ları alta kaydır
- `FittedBox` — içeriği ölçeklendirme
- `AspectRatio` — en/boy oranı koruma
- Farklı ekran boyutları için farklı layout'lar
- `OrientationBuilder` — yönlendirme

---

## 1. Responsive vs Adaptive

```
Responsive Tasarım:
  Aynı widget → ekran boyutuna göre esneyip büzülür
  Örn: Sütun sayısı 1 → 2 → 3 olur

Adaptive Tasarım:
  Farklı platformlar → farklı widget'lar
  Örn: iOS'ta CupertinoButton, Android'de ElevatedButton
```

Flutter'da genellikle ikisi birlikte kullanılır.

---

## 2. MediaQuery — Ekran Bilgileri

```dart
@override
Widget build(BuildContext context) {
  // Ekran boyutu
  final boyut = MediaQuery.sizeOf(context);
  final genislik = boyut.width;
  final yukseklik = boyut.height;

  // Cihaz pikseli oranı
  final pikselOrani = MediaQuery.devicePixelRatioOf(context);

  // Sistem çentik/kenar boşlukları
  final padding = MediaQuery.paddingOf(context);

  // Klavye yüksekliği
  final klavyeYuksekligi = MediaQuery.viewInsetsOf(context).bottom;

  // Ekran yönü
  final yon = MediaQuery.orientationOf(context);

  return Column(
    children: [
      Text('Genişlik: ${genislik.toStringAsFixed(0)}'),
      Text('Yükseklik: ${yukseklik.toStringAsFixed(0)}'),
      Text('Yön: ${yon == Orientation.portrait ? "Dikey" : "Yatay"}'),
    ],
  );
}
```

---

## 3. Kırılım Noktaları (Breakpoints)

Ekran boyutlarına göre standart sınıflandırma:

```dart
// Kırılım noktası sabitleri
class Kirilim {
  static const double mobil = 600;
  static const double tablet = 900;
  static const double masaustu = 1200;
}

// Kullanım
Widget _duzeniSec(BuildContext context) {
  final genislik = MediaQuery.sizeOf(context).width;

  if (genislik < Kirilim.mobil) {
    return const MobilDuzen();     // Tek sütun
  } else if (genislik < Kirilim.tablet) {
    return const TabletDuzen();    // İki sütun
  } else {
    return const MasaustuDuzen();  // Üç+ sütun
  }
}
```

---

## 4. LayoutBuilder

`MediaQuery` ekran boyutunu verir; `LayoutBuilder` ise o widget'ın **ebeveyninden aldığı** alanı verir. Bileşen bazlı responsive tasarım için daha güvenlidir:

```dart
LayoutBuilder(
  builder: (context, kisitlamalar) {
    final maks = kisitlamalar.maxWidth;

    if (maks < 400) {
      // Küçük alan → tek sütun
      return const Column(children: [...]);
    } else {
      // Geniş alan → iki sütun
      return const Row(children: [...]);
    }
  },
)
```

---

## 5. Flexible ve Expanded

`Row` / `Column` içindeki alan paylaşımı:

```dart
Row(
  children: [
    // Expanded: Kalan tüm alanı al
    Expanded(
      flex: 2,      // 2 birim (2/3 oranında)
      child: Container(color: Colors.blue, height: 50),
    ),
    Expanded(
      flex: 1,      // 1 birim (1/3 oranında)
      child: Container(color: Colors.red, height: 50),
    ),
  ],
)
```

```
flex: 2 ve flex: 1 → toplam 3 birim
  Mavi: 2/3 genişlik
  Kırmızı: 1/3 genişlik
```

`Flexible` vs `Expanded`:
- `Expanded`: Tüm kalan alanı **zorla** doldurur
- `Flexible`: Yalnızca **ihtiyacı kadar** yer alır (taşmaz)

---

## 6. Wrap — Taşmayı Önle

`Row` çok dolunca alt satıra geçer:

```dart
Wrap(
  spacing: 8,          // Yatay boşluk
  runSpacing: 8,       // Dikey boşluk (satırlar arası)
  alignment: WrapAlignment.start,
  children: etiketler.map((e) => Chip(label: Text(e))).toList(),
)
```

---

## 7. FittedBox — Ölçeklendirme

İçeriği ebeveyn alanına sığdır:

```dart
FittedBox(
  fit: BoxFit.scaleDown,   // Sadece küçült (büyütme)
  child: Text(
    'Çok Uzun Bir Başlık Metni',
    style: const TextStyle(fontSize: 40),
  ),
)
```

| `BoxFit` değeri | Açıklama |
|----------------|----------|
| `contain` | En boy oranını koruyarak sığdır |
| `cover` | Tüm alanı kaplasın, kırp |
| `fill` | Zorla doldur (bozulabilir) |
| `scaleDown` | Gerekirse küçült, büyütme |
| `fitWidth` | Genişliğe göre sığdır |
| `fitHeight` | Yüksekliğe göre sığdır |

---

## 8. AspectRatio — En/Boy Oranı

```dart
AspectRatio(
  aspectRatio: 16 / 9,   // 16:9 oranında
  child: Container(
    color: Colors.black,
    child: const Icon(Icons.play_circle, color: Colors.white, size: 48),
  ),
)
```

---

## 9. OrientationBuilder

Cihaz döndürüldüğünde farklı düzen:

```dart
OrientationBuilder(
  builder: (context, orientation) {
    return GridView.count(
      crossAxisCount: orientation == Orientation.portrait
          ? 2   // Dikey: 2 sütun
          : 4,  // Yatay: 4 sütun
      children: /* ürünler */,
    );
  },
)
```

---

## 10. Responsive Layout Örüntüsü

Profesyonel uygulamalarda yaygın kullanılan pattern:

```dart
// Responsive helper sınıfı
class R {
  final BuildContext _ctx;
  R(this._ctx);

  double get w => MediaQuery.sizeOf(_ctx).width;
  double get h => MediaQuery.sizeOf(_ctx).height;

  bool get mobil => w < 600;
  bool get tablet => w >= 600 && w < 900;
  bool get masaustu => w >= 900;

  // Değer seçici: mobil / tablet / masaüstü
  T sec<T>({required T mobil, required T tablet, required T masaustu}) {
    if (this.masaustu) return masaustu;
    if (this.tablet) return tablet;
    return mobil;
  }
}

// Kullanım
@override
Widget build(BuildContext context) {
  final r = R(context);
  return GridView.count(
    crossAxisCount: r.sec(mobil: 1, tablet: 2, masaustu: 3),
    childAspectRatio: r.sec(mobil: 1.0, tablet: 0.8, masaustu: 0.75),
    children: /* ürünler */,
  );
}
```

---

## Responsive Tasarım Özeti

| Widget | Kullanım |
|--------|----------|
| `MediaQuery` | Ekran genişlik/yükseklik bilgisi |
| `LayoutBuilder` | Ebeveyn boyutuna göre düzen |
| `Expanded` | Kalan alanı tüm doldur |
| `Flexible` | Kalan alanda esnek büyü |
| `Wrap` | Taşanı alt satıra geçir |
| `FittedBox` | İçeriği ölçeklendirerek sığdır |
| `AspectRatio` | En/boy oranını koru |
| `OrientationBuilder` | Dikey/yatay yönlendirme |

---

## Alıştırmalar

1. 3 farklı kırılım noktasında (mobil/tablet/masaüstü) farklı ızgara sütunları gösteren ürün kataloğu yapın.
2. `OrientationBuilder` kullanın: dikeyde liste, yatayda ızgara görünsün.
3. `LayoutBuilder` ile bir bileşen yapın: 300px altında tek sütun, üstünde iki sütun.
4. `Wrap` kullanarak tag/etiket listesi yapın — etiket uzunluklarından bağımsız düzgün sığsın.

---

**Önceki Ders:** [Ders 04 — Tema ve Stil](../Ders04_Tema_ve_Stil/ders_notu.md)
**Sonraki Modül:** [Modül 4 — State Management](../../Modul4_State_Management/)
