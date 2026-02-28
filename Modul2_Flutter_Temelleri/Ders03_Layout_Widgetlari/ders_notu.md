# Ders 03 — Layout Widget'ları

## Bu Derste Neler Öğreneceğiz?
- `Column` ve `Row` — dikey/yatay hizalama
- `Stack` — üst üste yerleştirme
- `Expanded` ve `Flexible` — esnek genişlik
- `Wrap` — taşan elemanları alt satıra al
- `ListView` — kaydırılabilir liste
- `GridView` — ızgara düzeni
- `Align`, `Positioned` — hassas konumlandırma

---

## 1. Column ve Row — Temel Hizalama

```
Column (dikey)      Row (yatay)
┌──────┐            ┌──────────────┐
│  A   │            │  A  │ B │ C  │
│──────│            └──────────────┘
│  B   │
│──────│
│  C   │
└──────┘
```

### Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,    // Dikey hizalama
  crossAxisAlignment: CrossAxisAlignment.start,   // Yatay hizalama
  mainAxisSize: MainAxisSize.min,                 // Min yükseklik
  children: [
    Text('Birinci'),
    SizedBox(height: 8),
    Text('İkinci'),
    SizedBox(height: 8),
    Text('Üçüncü'),
  ],
)
```

### Row

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Yatay hizalama
  crossAxisAlignment: CrossAxisAlignment.center,     // Dikey hizalama
  children: [
    Icon(Icons.home),
    Text('Ana Sayfa'),
    Icon(Icons.arrow_forward),
  ],
)
```

### MainAxisAlignment Seçenekleri

| Değer | Açıklama |
|-------|----------|
| `start` | Başa hizala |
| `end` | Sona hizala |
| `center` | Ortala |
| `spaceBetween` | Araya eşit boşluk |
| `spaceAround` | Etrafına eşit boşluk |
| `spaceEvenly` | Tüm boşluklar eşit |

### CrossAxisAlignment Seçenekleri

| Değer | Açıklama |
|-------|----------|
| `start` | Başa hizala (Column→sol, Row→üst) |
| `end` | Sona hizala |
| `center` | Ortala |
| `stretch` | Tam genişliğe yay |

---

## 2. Expanded ve Flexible

Column/Row içindeki widget'ların kalan alanı paylaşması için:

```dart
Row(
  children: [
    // Sabit genişlik
    Container(width: 60, height: 60, color: Colors.red),

    // Kalan alanın tamamını al
    Expanded(
      child: Container(height: 60, color: Colors.blue),
    ),

    // Kalan alanın belirli oranını al (flex)
    Expanded(
      flex: 2,  // 2 pay
      child: Container(height: 60, color: Colors.green),
    ),
  ],
)
// Kırmızı: sabit 60px, Mavi: 1 pay, Yeşil: 2 pay
```

```dart
// Flexible: Expanded gibi ama taşmaz (shrink edebilir)
Row(
  children: [
    Flexible(child: Text('Çok uzun bir metin...')),
    Icon(Icons.arrow_forward),
  ],
)
```

---

## 3. Stack — Üst Üste Yerleştirme

Widget'ları birbirinin üzerine yerleştirmek için:

```dart
Stack(
  alignment: Alignment.center,  // Varsayılan hizalama
  children: [
    // En altta
    Container(width: 200, height: 200, color: Colors.blue),

    // Ortada
    Container(width: 150, height: 150, color: Colors.green),

    // En üstte
    Container(width: 100, height: 100, color: Colors.red),
  ],
)
```

### Positioned — Hassas Konum

```dart
Stack(
  children: [
    Image.asset('arka_plan.jpg'),

    // Sol üst köşe
    Positioned(
      top: 16,
      left: 16,
      child: Icon(Icons.favorite, color: Colors.white),
    ),

    // Sağ alt köşe
    Positioned(
      bottom: 16,
      right: 16,
      child: Text('Fotoğraf açıklaması', style: TextStyle(color: Colors.white)),
    ),

    // Tam genişlik, altta
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(8),
        child: Text('Alt başlık', style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
)
```

---

## 4. Wrap — Taşan Elemanları Sar

Row'dan farklı olarak elemanlar sığmazsa alt satıra geçer:

```dart
Wrap(
  spacing: 8,      // Yatay boşluk
  runSpacing: 8,   // Satır arası boşluk
  alignment: WrapAlignment.start,
  children: [
    Chip(label: Text('Flutter')),
    Chip(label: Text('Dart')),
    Chip(label: Text('Android')),
    Chip(label: Text('iOS')),
    Chip(label: Text('Web')),
    Chip(label: Text('Desktop')),
  ],
)
```

---

## 5. ListView — Kaydırılabilir Liste

```dart
// Kısa listeler için
ListView(
  padding: EdgeInsets.all(8),
  children: [
    ListTile(
      leading: Icon(Icons.person),
      title: Text('Ahmet Yılmaz'),
      subtitle: Text('Flutter Geliştirici'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {},
    ),
    Divider(),
    ListTile(/* ... */),
  ],
)

// Uzun / sonsuz listeler için (bellek dostu):
ListView.builder(
  itemCount: urunler.length,
  itemBuilder: (context, index) {
    final urun = urunler[index];
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(urun.ad),
        subtitle: Text('${urun.fiyat} TL'),
        leading: Icon(Icons.shopping_bag),
      ),
    );
  },
)

// Ayırıcılı liste
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (_, __) => Divider(),
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)
```

---

## 6. GridView — Izgara Düzeni

```dart
// Sabit sütun sayısı
GridView.count(
  crossAxisCount: 2,        // 2 sütun
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  padding: EdgeInsets.all(8),
  children: [
    for (int i = 0; i < 6; i++)
      Card(child: Center(child: Text('Kart $i'))),
  ],
)

// Dinamik (bellek dostu):
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    childAspectRatio: 1.0,  // Kare hücreler
  ),
  itemCount: fotolar.length,
  itemBuilder: (context, index) => Image.network(fotolar[index]),
)

// Eşit genişlikte (responsive):
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,  // Her hücre en fazla 200px genişlik
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 20,
  itemBuilder: (context, index) => Container(
    color: Colors.primaries[index % Colors.primaries.length],
    child: Center(child: Text('$index')),
  ),
)
```

---

## 7. SingleChildScrollView — Tek Widget'ı Kaydır

Column içindeki içerik ekrandan büyüdüğünde:

```dart
// YANLIŞ (overflow hatası):
Column(children: [/* çok fazla içerik */])

// DOĞRU:
SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [/* ne kadar içerik olursa olsun */],
  ),
)
```

---

## 8. Layout Hata Ayıklama

```dart
// Widget sınırlarını görmek için:
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true; // Tüm widget sınırlarını çizer
  runApp(const MyApp());
}

// Ya da sadece belirli bir Container'a renk verin:
Container(color: Colors.red.withOpacity(0.3), child: widget)
```

---

## Özet

```
Layout widget'ları:
├── Column          → Dikey sıralama
├── Row             → Yatay sıralama
├── Stack           → Üst üste yerleştirme
│   └── Positioned  → Hassas konumlandırma (Stack içinde)
├── Expanded        → Kalan alanı kapla
├── Flexible        → Esnek alan (taşmaz)
├── Wrap            → Kaydırmadan sar
├── ListView        → Kaydırılabilir dikey liste
├── GridView        → Izgara düzeni
└── SingleChildScrollView → Tek widget kaydırma

Boşluk:
├── SizedBox(height: x) → Dikey boşluk
├── SizedBox(width: x)  → Yatay boşluk
└── Spacer()            → Esnek boşluk (Row/Column içinde)
```

---

## Alıştırmalar

1. 3 eşit genişlikte sütun oluşturun (`Expanded` + `Row`).
2. Bir fotoğrafın üzerine kalın başlık yerleştiren `Stack` yapısı kurun.
3. Yazı etiketlerini (`Chip`) `Wrap` ile sarın; ekran genişliğine göre otomatik sarsın.
4. 20 öğeli bir liste oluşturun — ilk 3'ü özel stil, geri kalanlar standart `ListTile`.
5. Ürün kataloğu: `GridView.builder` ile en az 8 ürün kartı (resim + isim + fiyat) gösterin.

---

**Önceki Ders:** [Ders 02 — Widget Kavramı](../Ders02_Widget_Kavrami/ders_notu.md)
**Sonraki Ders:** [Ders 04 — StatefulWidget](../Ders04_StatefulWidget/ders_notu.md)
