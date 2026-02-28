# Ders 03 — Fonksiyonlar

## Bu Derste Neler Öğreneceğiz?
- Fonksiyon nedir ve neden kullanılır?
- Fonksiyon tanımlama ve çağırma
- Parametre türleri (zorunlu, isteğe bağlı, isimli)
- Dönüş tipleri ve `void`
- Arrow function (`=>`)
- Higher-order functions (fonksiyon alan/döndüren fonksiyonlar)
- Anonim fonksiyonlar (lambda)

---

## 1. Fonksiyon Nedir?

Fonksiyon; belirli bir işi yapan, isim verilmiş, tekrar tekrar çağırılabilen kod bloğudur.

```
┌─────────────────────────────────────┐
│  fonksiyon(girdi) → işlem → çıktı  │
└─────────────────────────────────────┘

Örnek:
  topla(3, 5) → 3+5 hesaplar → 8 döner
```

**Neden kullanırız?**
- Aynı kodu tekrar yazmaktan kaçınmak (DRY: Don't Repeat Yourself)
- Kodu daha okunabilir ve yönetilebilir yapmak
- Test edilebilirlik

---

## 2. Fonksiyon Tanımlama

### Temel Sözdizimi

```dart
döndürülenTip fonksiyonAdi(parametreler) {
  // gövde
  return değer;
}
```

```dart
// Örnek: İki sayıyı toplayan fonksiyon
int topla(int a, int b) {
  return a + b;
}

// Çağırma:
int sonuc = topla(3, 5);
print(sonuc); // 8
```

### void — Değer Döndürmeyen Fonksiyon

```dart
void selamVer(String isim) {
  print("Merhaba, $isim!");
  // return yok, ya da sadece "return;" yazılabilir
}

selamVer("Ayşe"); // Merhaba, Ayşe!
```

---

## 3. Arrow Fonksiyon (`=>`)

Tek satırlık fonksiyonlar için kısaltma:

```dart
// Uzun yol:
int kare(int x) {
  return x * x;
}

// Arrow ile kısa yol:
int kare(int x) => x * x;

// void arrow:
void selamVer(String isim) => print("Merhaba, $isim!");
```

---

## 4. Parametre Türleri

### Zorunlu (Required) Parametreler

```dart
double dikdortgenAlani(double en, double boy) {
  return en * boy;
}

// Çağırırken her iki parametre de verilmek zorunda:
print(dikdortgenAlani(5, 3)); // 15.0
```

### İsteğe Bağlı (Optional) Parametreler — `[]`

```dart
String selamla(String isim, [String? unvan]) {
  if (unvan != null) {
    return "Merhaba, $unvan $isim!";
  }
  return "Merhaba, $isim!";
}

print(selamla("Ahmet"));          // Merhaba, Ahmet!
print(selamla("Ahmet", "Dr."));   // Merhaba, Dr. Ahmet!
```

### Varsayılan Değerli Parametreler

```dart
double faizHesapla(double anapara, {double faizOrani = 0.10, int yil = 1}) {
  return anapara * faizOrani * yil;
}

// Çağırma örnekleri:
print(faizHesapla(10000));                      // 1000.0 (varsayılanlar)
print(faizHesapla(10000, faizOrani: 0.15));     // 1500.0
print(faizHesapla(10000, yil: 3));              // 3000.0
print(faizHesapla(10000, faizOrani: 0.20, yil: 2)); // 4000.0
```

### İsimli (Named) Parametreler — `{}`

```dart
// {} ile tanımlanan parametreler isimle çağırılır
void kullaniciBilgisi({
  required String isim,   // required = zorunlu isimli parametre
  required int yas,
  String sehir = "Bilinmiyor",
}) {
  print("İsim: $isim, Yaş: $yas, Şehir: $sehir");
}

// Çağırma (sıra önemli değil, isim önemli):
kullaniciBilgisi(isim: "Fatma", yas: 28);
kullaniciBilgisi(yas: 35, isim: "Mehmet", sehir: "Ankara");
```

---

## 5. Çoklu Return — Dart'ta Mümkün Değil (Ama Alternatifler Var)

```dart
// Dart tek değer döndürür, ama Map veya Record ile birden fazla döndürebilirsiniz

// Map ile:
Map<String, dynamic> minMax(List<int> sayilar) {
  sayilar.sort();
  return {"min": sayilar.first, "max": sayilar.last};
}

var sonuc = minMax([5, 2, 8, 1, 9]);
print("Min: ${sonuc['min']}, Max: ${sonuc['max']}"); // Min: 1, Max: 9

// Dart 3.0+ Record (Tuple) ile:
(int, int) minMaxRecord(List<int> sayilar) {
  sayilar.sort();
  return (sayilar.first, sayilar.last);
}

var (min, max) = minMaxRecord([5, 2, 8, 1, 9]);
print("Min: $min, Max: $max");
```

---

## 6. Anonim Fonksiyonlar (Lambda)

İsim verilmeden tanımlanan fonksiyonlar. Genellikle başka bir fonksiyona parametre olarak verilir.

```dart
// İsimli fonksiyon:
int ikiKati(int x) => x * 2;

// Anonim fonksiyon (lambda):
var ikiKati2 = (int x) => x * 2;

print(ikiKati(5));   // 10
print(ikiKati2(5));  // 10

// Koleksiyonlarla kullanım:
List<int> sayilar = [1, 2, 3, 4, 5];

// Her elemanı 2 ile çarp
List<int> ikiKatlari = sayilar.map((x) => x * 2).toList();
print(ikiKatlari); // [2, 4, 6, 8, 10]

// Çift sayıları filtrele
List<int> ciftler = sayilar.where((x) => x % 2 == 0).toList();
print(ciftler); // [2, 4]

// Toplamı bul
int toplam = sayilar.reduce((a, b) => a + b);
print(toplam); // 15
```

---

## 7. Higher-Order Functions

Fonksiyon alan veya fonksiyon döndüren fonksiyonlar:

```dart
// Fonksiyon alan fonksiyon:
void islemi3KezYap(void Function() islem) {
  for (int i = 0; i < 3; i++) {
    islem();
  }
}

islemi3KezYap(() => print("Merhaba!"));
// Merhaba!
// Merhaba!
// Merhaba!

// Fonksiyon döndüren fonksiyon:
Function carpanUret(int carpan) {
  return (int sayi) => sayi * carpan;
}

var ucKati = carpanUret(3);
var besKati = carpanUret(5);

print(ucKati(4));  // 12
print(besKati(4)); // 20
```

---

## 8. Rekürsif (Kendini Çağıran) Fonksiyonlar

```dart
// Faktöriyel: n! = n × (n-1) × ... × 1
int faktoryel(int n) {
  if (n <= 1) return 1;        // Taban durum (base case)
  return n * faktoryel(n - 1); // Rekürsif çağrı
}

print(faktoryel(5)); // 5 × 4 × 3 × 2 × 1 = 120

// Fibonacci dizisi
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

for (int i = 0; i <= 8; i++) {
  print("F($i) = ${fibonacci(i)}");
}
```

---

## Özet

```
Fonksiyon türleri:
├── void fonksiyon()       → Değer döndürmez
├── int fonksiyon()        → Değer döndürür
├── int fonksiyon() => x   → Arrow fonksiyon (tek satır)
└── (int x) => x * 2       → Anonim fonksiyon (lambda)

Parametre türleri:
├── (int a, int b)         → Zorunlu, sıra önemli
├── ([int? a])             → İsteğe bağlı, pozisyonel
└── ({required int a})     → İsimli, zorunlu veya optional
```

---

## Alıştırmalar

1. Verilen bir sayının faktöriyelini hesaplayan fonksiyon yazın.
2. Bir string'i tersine çeviren fonksiyon yazın (`"Dart"` → `"traD"`).
3. Verilen bir liste içindeki en büyük sayıyı bulan fonksiyon yazın.
4. İsim, soyisim ve isteğe bağlı unvan alıp tam adı döndüren fonksiyon yazın.
5. Sayı listesi alıp ortalamasını döndüren fonksiyon yazın.

---

**Önceki Ders:** [Ders 02 — Kontrol Akışı](../Ders02_Kontrol_Akisi/ders_notu.md)
**Sonraki Ders:** [Ders 04 — Koleksiyonlar](../Ders04_Koleksiyonlar/ders_notu.md)
