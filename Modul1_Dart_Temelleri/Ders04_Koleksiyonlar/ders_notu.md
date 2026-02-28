# Ders 04 — Koleksiyonlar: List, Map, Set

## Bu Derste Neler Öğreneceğiz?
- `List` — Sıralı elemanlar (dizi)
- `Map` — Anahtar-değer çiftleri
- `Set` — Benzersiz elemanlar
- Spread operatörü (`...`)
- Koleksiyon işlemleri (map, where, reduce, forEach...)

---

## 1. List — Sıralı Elemanlar

List, sırası olan ve tekrar eden elemanlara izin veren bir koleksiyondur.

```
List: [10, 20, 30, 40, 50]
       ↑    ↑    ↑    ↑    ↑
      [0]  [1]  [2]  [3]  [4]  ← indeks (0'dan başlar)
```

### List Oluşturma

```dart
// Tip belirterek
List<String> meyveler = ["elma", "armut", "kiraz"];

// var ile
var sayilar = [1, 2, 3, 4, 5];

// Boş liste
List<int> bos = [];
List<int> bos2 = List.empty(growable: true);

// Belirli boyutla
List<int> sifirlar = List.filled(5, 0); // [0, 0, 0, 0, 0]

// Üretilerek
List<int> kareler = List.generate(5, (i) => i * i); // [0, 1, 4, 9, 16]
```

### List Temel İşlemleri

```dart
List<String> renkler = ["kırmızı", "mavi", "yeşil"];

// Eleman ekleme
renkler.add("sarı");          // Sona ekle
renkler.insert(1, "mor");     // İndekse ekle
renkler.addAll(["turuncu", "pembe"]); // Çoklu ekle

// Eleman erişimi
print(renkler[0]);            // kırmızı
print(renkler.first);         // kırmızı
print(renkler.last);          // pembe

// Eleman silme
renkler.remove("mavi");       // Değere göre sil
renkler.removeAt(0);          // İndekse göre sil
renkler.clear();              // Tümünü sil

// Bilgi alma
print(renkler.length);        // Eleman sayısı
print(renkler.isEmpty);       // Boş mu?
print(renkler.contains("kırmızı")); // İçeriyor mu?
print(renkler.indexOf("yeşil"));    // Kaçıncı indekste?
```

### List Dönüşüm Metodları

```dart
List<int> sayilar = [3, 1, 4, 1, 5, 9, 2, 6];

// Sıralama
sayilar.sort();                              // [1, 1, 2, 3, 4, 5, 6, 9]
sayilar.sort((a, b) => b.compareTo(a));      // Ters sıra: [9, 6, 5, ...]

// map: Her elemanı dönüştür
List<int> ikiKatlari = sayilar.map((x) => x * 2).toList();

// where: Filtrele
List<int> buyukler = sayilar.where((x) => x > 4).toList();

// forEach: Her eleman için işlem yap
sayilar.forEach((x) => print(x));

// reduce: Tek değere indir
int toplam = sayilar.reduce((a, b) => a + b);

// any / every
bool biriBestenBuyuk = sayilar.any((x) => x > 5);
bool hepsiPozitif = sayilar.every((x) => x > 0);

// expand: İç içe listeyi düzleştir
List<List<int>> ic_ice = [[1, 2], [3, 4], [5, 6]];
List<int> duz = ic_ice.expand((x) => x).toList(); // [1, 2, 3, 4, 5, 6]

// toSet: Tekrarları kaldır
List<int> tekrarli = [1, 2, 2, 3, 3, 3, 4];
Set<int> benzersiz = tekrarli.toSet(); // {1, 2, 3, 4}
```

---

## 2. Map — Anahtar-Değer Çiftleri

Map, her anahtarın benzersiz olduğu anahtar-değer çiftlerini saklar.

```
Map:
┌─────────────┬──────────────┐
│  Anahtar    │    Değer     │
├─────────────┼──────────────┤
│  "isim"     │  "Ahmet"     │
│  "yas"      │  25          │
│  "sehir"    │  "İstanbul"  │
└─────────────┴──────────────┘
```

### Map Oluşturma

```dart
// String anahtarlı
Map<String, dynamic> kisi = {
  "isim": "Ahmet",
  "yas": 25,
  "sehir": "İstanbul",
};

// int anahtarlı
Map<int, String> aylar = {
  1: "Ocak",
  2: "Şubat",
  3: "Mart",
};

// Boş map
Map<String, int> bos = {};
```

### Map İşlemleri

```dart
Map<String, dynamic> urun = {
  "ad": "Laptop",
  "fiyat": 15000,
  "stok": 50,
};

// Erişim
print(urun["ad"]);         // Laptop
print(urun["fiyat"]);      // 15000
print(urun["renk"]);       // null (yoksa null döner)

// Güvenli erişim
print(urun["renk"] ?? "Belirtilmemiş"); // Belirtilmemiş

// Ekleme / Güncelleme
urun["renk"] = "Gümüş";    // Yeni anahtar ekle
urun["fiyat"] = 14000;     // Mevcut değeri güncelle

// Silme
urun.remove("stok");

// Bilgi
print(urun.length);                   // Kaç çift var?
print(urun.keys.toList());           // Anahtarlar
print(urun.values.toList());         // Değerler
print(urun.containsKey("ad"));       // Anahtar var mı?
print(urun.containsValue("Laptop")); // Değer var mı?

// Gezinme
urun.forEach((anahtar, deger) {
  print("$anahtar: $deger");
});
```

---

## 3. Set — Benzersiz Elemanlar

Set, tekrar eden elemanları otomatik olarak atar. Sırası yoktur.

```dart
// Oluşturma
Set<String> hobiler = {"yüzme", "okuma", "müzik"};
Set<int> sayilar = {1, 2, 3, 4, 5};

// Tekrarlı eleman eklemeye çalışırsak:
hobiler.add("yüzme"); // Zaten var, eklenmez
hobiler.add("spor");  // Yeni, eklenir

// Set işlemleri
Set<int> a = {1, 2, 3, 4, 5};
Set<int> b = {4, 5, 6, 7, 8};

print(a.union(b));        // {1,2,3,4,5,6,7,8} — Birleşim
print(a.intersection(b)); // {4,5}              — Kesişim
print(a.difference(b));   // {1,2,3}            — Fark
print(a.contains(3));     // true
```

---

## 4. Spread Operatörü (`...`)

Bir koleksiyonun elemanlarını başka bir koleksiyona yaymak için:

```dart
List<int> liste1 = [1, 2, 3];
List<int> liste2 = [4, 5, 6];

// Spread ile birleştir
List<int> birlesik = [...liste1, ...liste2]; // [1, 2, 3, 4, 5, 6]

// Null-aware spread
List<int>? nullable;
List<int> guvenli = [...?nullable, 7, 8]; // [7, 8] — hata vermez
```

---

## 5. Collection if ve Collection for

```dart
bool adminMi = true;

List<String> menuOgeleri = [
  "Ana Sayfa",
  "Profil",
  if (adminMi) "Admin Paneli",  // Koşullu ekleme
];
// adminMi true ise: ["Ana Sayfa", "Profil", "Admin Paneli"]

List<int> ciftSayilar = [
  for (int i = 1; i <= 10; i++)
    if (i % 2 == 0) i,  // 1-10 arasındaki çiftler
];
// [2, 4, 6, 8, 10]
```

---

## Özet Karşılaştırma

| Özellik | List | Map | Set |
|---------|------|-----|-----|
| Sırası var mı? | ✅ Evet | ❌ Yok | ❌ Yok |
| Tekrar eden eleman? | ✅ İzin verir | ❌ (anahtar unique) | ❌ İzin vermez |
| Erişim yöntemi | İndeks `[0]` | Anahtar `["key"]` | - |
| Ne zaman kullanılır? | Sıralı veri listesi | Etiketli veri | Benzersiz elemanlar |

---

## Alıştırmalar

1. 10 şehrin isimlerini bir List'e ekleyin ve alfabetik olarak sıralayıp yazdırın.
2. Öğrenci adlarını ve notlarını Map ile saklayın, ortalaması 70'in üzerindeki öğrencileri listeleyin.
3. İki farklı setten ortak elemanları (intersection) bulun.
4. `[1, 2, 2, 3, 3, 3, 4, 4, 4, 4]` listesinde her sayının kaç kez tekrarlandığını bir Map ile hesaplayın.
5. Bir alışveriş sepeti simülasyonu: ürün adı ve fiyatı saklayan Map kullanın, sepete ekleme/çıkarma yapın, toplam tutarı hesaplayın.

---

**Önceki Ders:** [Ders 03 — Fonksiyonlar](../Ders03_Fonksiyonlar/ders_notu.md)
**Sonraki Ders:** [Ders 05 — OOP: Sınıflar ve Nesneler](../Ders05_OOP_Siniflar/ders_notu.md)
