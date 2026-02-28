# Ders 05 — Nesne Yönelimli Programlama (OOP)

## Bu Derste Neler Öğreneceğiz?
- Sınıf (class) ve nesne (object) kavramları
- Constructor (yapıcı) türleri
- Getter ve Setter
- Kalıtım (Inheritance)
- `abstract` sınıflar ve arayüzler
- Mixin'ler
- `static` üyeler

---

## 1. Sınıf ve Nesne Nedir?

**Sınıf:** Bir şablondur. Nesnenin nasıl görüneceğini ve nasıl davranacağını tanımlar.
**Nesne:** Sınıftan üretilen somut örnektir.

```
Sınıf (Şablon)          Nesne (Örnek)
┌───────────────┐        ┌──────────────────┐
│  class Araba  │  →→→   │  Araba            │
│  - marka      │  üret  │  marka: "Toyota"  │
│  - hiz        │        │  hiz: 120         │
│  - sur()      │        │  sur()            │
└───────────────┘        └──────────────────┘
```

---

## 2. Temel Sınıf Tanımlama

```dart
class Ogrenci {
  // Özellikler (fields/properties) — sınıfa ait veri alanları
  String isim;          // Öğrencinin adı (metin türünde)
  int yas;              // Öğrencinin yaşı (tam sayı türünde)
  double notOrtalaması; // GPA değeri (ondalıklı sayı türünde)

  // Constructor (yapıcı metod) — nesne oluşturulurken otomatik çalışır
  // 'this.' sözdizimi parametreyi doğrudan ilgili alana atar
  Ogrenci(this.isim, this.yas, this.notOrtalaması);

  // Metod — sınıfın davranışını (yapabileceklerini) tanımlar
  void kendiniTanit() {
    // String interpolation ($değişken) ile değerleri metne gömer
    print("Ben $isim, $yas yaşındayım. Ortalam: $notOrtalaması");
  }

  // Arrow fonksiyon (=>) — tek satırlık kısa metod yazımı
  // notOrtalaması 2.0 veya üstüyse true, altındaysa false döner
  bool basariliMi() => notOrtalaması >= 2.0;
}

// Kullanım:
void main() {
  // 'Ogrenci' tipinde iki nesne (instance) oluşturuluyor
  Ogrenci ogr1 = Ogrenci("Ahmet", 20, 3.2);   // isim, yas, notOrtalaması
  Ogrenci ogr2 = Ogrenci("Zeynep", 22, 1.8);  // notOrtalaması 2.0 altında

  ogr1.kendiniTanit(); // nesnenin metodunu çağırma: nokta (.) operatörü
  // ${...} sözdizimi: metod dönüş değerini string içine gömer
  print("Ahmet başarılı mı: ${ogr1.basariliMi()}");  // 3.2 >= 2.0 → true
  print("Zeynep başarılı mı: ${ogr2.basariliMi()}"); // 1.8 >= 2.0 → false
}
```

---

## 3. Constructor Türleri

### Varsayılan Constructor

```dart
class Nokta {
  double x;
  double y;

  // Uzun yol:
  Nokta(double x, double y) {
    this.x = x;
    this.y = y;
  }

  // Kısa yol (this. syntactic sugar):
  Nokta(this.x, this.y);
}
```

### İsimli Constructor (Named Constructor)

```dart
class Renk {
  int r, g, b;

  Renk(this.r, this.g, this.b);

  // İsimli constructorlar
  Renk.kirmizi() : r = 255, g = 0, b = 0;
  Renk.yesil()   : r = 0, g = 255, b = 0;
  Renk.mavi()    : r = 0, g = 0, b = 255;
  Renk.siyah()   : r = 0, g = 0, b = 0;
}

var r = Renk.kirmizi();
var b = Renk.mavi();
```

### `const` Constructor

```dart
class ImmutableNokta {
  final double x;
  final double y;

  const ImmutableNokta(this.x, this.y);
}

const ImmutableNokta merkez = ImmutableNokta(0, 0); // Derleme zamanı sabiti
```

### Factory Constructor

```dart
class Singleton {
  static Singleton? _instance;

  Singleton._internal();

  factory Singleton() {
    _instance ??= Singleton._internal();
    return _instance!;
  }
}

var a = Singleton();
var b = Singleton();
print(identical(a, b)); // true — aynı nesne
```

---

## 4. Getter ve Setter

```dart
class BankaHesabi {
  String sahip;
  double _bakiye; // private (alt tire ile)

  BankaHesabi(this.sahip, this._bakiye);

  // Getter
  double get bakiye => _bakiye;

  // Computed getter
  String get durum => _bakiye > 0 ? "Aktif" : "Borçlu";

  // Setter (doğrulama ile)
  set bakiye(double yeniDeger) {
    if (yeniDeger < -10000) {
      throw Exception("Maksimum borç limitini aştınız!");
    }
    _bakiye = yeniDeger;
  }

  void para_yatir(double miktar) {
    if (miktar <= 0) throw Exception("Miktar pozitif olmalı");
    _bakiye += miktar;
    print("${miktar} TL yatırıldı. Yeni bakiye: $_bakiye TL");
  }

  void para_cek(double miktar) {
    if (miktar > _bakiye) throw Exception("Yetersiz bakiye!");
    _bakiye -= miktar;
    print("${miktar} TL çekildi. Kalan bakiye: $_bakiye TL");
  }
}
```

---

## 5. Kalıtım (Inheritance) — `extends`

Alt sınıf, üst sınıfın özelliklerini ve metodlarını devralır.

```dart
class Hayvan {
  String isim;
  int yas;

  Hayvan(this.isim, this.yas);

  void sesCikar() => print("...");

  void bilgiVer() => print("$isim, $yas yaşında");
}

class Kedi extends Hayvan {
  String renk;

  Kedi(String isim, int yas, this.renk) : super(isim, yas);

  @override
  void sesCikar() => print("$isim: Miyav!");

  void tikmaCik() => print("$isim tırmaladı!");
}

class Kopek extends Hayvan {
  String cins;

  Kopek(String isim, int yas, this.cins) : super(isim, yas);

  @override
  void sesCikar() => print("$isim: Hav hav!");
}

// Kullanım:
Kedi kedi = Kedi("Pamuk", 3, "Beyaz");
Kopek kopek = Kopek("Karabaş", 5, "Golden");

kedi.sesCikar();   // Pamuk: Miyav!
kedi.bilgiVer();   // Pamuk, 3 yaşında
kopek.sesCikar();  // Karabaş: Hav hav!
```

---

## 6. Abstract Sınıf ve Arayüz

### abstract — Soyut Sınıf

```dart
abstract class Sekil {
  // Soyut metod (alt sınıflar ZORUNDA implement etmeli)
  double alan();
  double cevre();

  // Somut metod (miras alınır)
  void bilgiVer() {
    print("Alan: ${alan().toStringAsFixed(2)}, Çevre: ${cevre().toStringAsFixed(2)}");
  }
}

class Daire extends Sekil {
  double yaricap;
  Daire(this.yaricap);

  @override
  double alan() => 3.14159 * yaricap * yaricap;

  @override
  double cevre() => 2 * 3.14159 * yaricap;
}

class Dikdortgen extends Sekil {
  double en, boy;
  Dikdortgen(this.en, this.boy);

  @override
  double alan() => en * boy;

  @override
  double cevre() => 2 * (en + boy);
}

// Kullanım (polimorfizm):
List<Sekil> sekiller = [Daire(5), Dikdortgen(4, 6)];
for (var sekil in sekiller) {
  sekil.bilgiVer(); // Her şekil kendi alan/çevresini hesaplar
}
```

### implements — Arayüz

Dart'ta her sınıf aynı zamanda bir arayüzdür.

```dart
abstract class Ucabilir {
  void uc();
}

abstract class YuzebilIr {
  void yuz();
}

class Ordek implements Ucabilir, YuzebilIr {
  @override
  void uc() => print("Ördek uçuyor");

  @override
  void yuz() => print("Ördek yüzüyor");
}
```

---

## 7. Mixin — Kod Paylaşımı

Kalıtım olmadan sınıflara özellik eklemek için:

```dart
mixin Kosubilir {
  void kos() => print("$runtimeType koşuyor!");
  double hiz = 10.0;
}

mixin Yuzebilir {
  void yuz() => print("$runtimeType yüzüyor!");
}

class Sporcu with Kosubilir, Yuzebilir {
  String isim;
  Sporcu(this.isim);
}

class Keci with Kosubilir {
  String isim;
  Keci(this.isim);
}

var sporcu = Sporcu("Mehmet");
sporcu.kos();  // Sporcu koşuyor!
sporcu.yuz();  // Sporcu yüzüyor!

var keci = Keci("Keçi");
keci.kos();    // Keci koşuyor!
```

---

## 8. static — Sınıf Düzeyinde Üyeler

```dart
class Matematik {
  static const double pi = 3.14159;

  static int topla(int a, int b) => a + b;
  static double karekok(double x) => x; // basitleştirilmiş

  // Nesne oluşturmaya gerek yok:
}

// Kullanım:
print(Matematik.pi);       // 3.14159
print(Matematik.topla(3, 5)); // 8
```

---

## Özet

```
OOP Kavramları:
├── class          → Şablon/blueprint
├── object         → Sınıftan üretilen nesne
├── constructor    → Nesneyi başlatan metod
├── getter/setter  → Erişim kontrollü özellikler
├── extends        → Kalıtım (bir üst sınıf)
├── abstract       → Soyut sınıf (tamamlanmamış)
├── implements     → Arayüz uygulama (çoklu)
├── mixin          → Kod paylaşımı (kalıtsız)
└── static         → Nesne gerektirmeyen üyeler
```

---

## Alıştırmalar

1. `Urun` sınıfı oluşturun: ad, fiyat, stok özellikleri; stokAzalt() ve indirimUygula() metodları.
2. `Sekil` abstract sınıfından `Ucgen` ve `Kare` türetip alan/çevre hesaplayın.
3. `Calisan`, `Mudur` (extends Calisan), `Yazilimci` (extends Calisan) hiyerarşisi oluşturun.
4. `Loglanabilir` mixin'i yazın: her metoddan önce/sonra log yazan bir karıştırıcı.
5. `Sepet` sınıfı yazın: ürün ekleme/çıkarma, toplam tutarı getter ile hesaplama.

---

**Önceki Ders:** [Ders 04 — Koleksiyonlar](../Ders04_Koleksiyonlar/ders_notu.md)
**Sonraki Ders:** [Ders 06 — Null Safety](../Ders06_Null_Safety/ders_notu.md)
