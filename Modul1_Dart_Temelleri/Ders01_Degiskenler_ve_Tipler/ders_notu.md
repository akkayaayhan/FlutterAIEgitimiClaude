# Ders 01 — Değişkenler ve Veri Tipleri

## Bu Derste Neler Öğreneceğiz?
- Dart'ta değişken nedir, nasıl tanımlanır?
- Temel veri tipleri nelerdir?
- `var`, `final`, `const` arasındaki fark
- Tip dönüşümleri
- String interpolasyon

---

## 1. Değişken Nedir?

Değişken, bir değeri saklamak için kullandığımız isimli bir "kutu"dur.

```
┌─────────────────────┐
│  isim = "Ahmet"     │  ← Bir String değeri saklıyor
└─────────────────────┘

┌─────────────────────┐
│  yas = 25           │  ← Bir int değeri saklıyor
└─────────────────────┘
```

---

## 2. Dart'ta Temel Veri Tipleri

| Tip | Açıklama | Örnek |
|-----|----------|-------|
| `int` | Tam sayı | `42`, `-10`, `0` |
| `double` | Ondalıklı sayı | `3.14`, `-0.5` |
| `String` | Metin | `"Merhaba"`, `'Dart'` |
| `bool` | Mantıksal değer | `true`, `false` |
| `dynamic` | Herhangi bir tip (kaçının!) | `"metin"` veya `42` |

---

## 3. Değişken Tanımlama

### Yöntem 1: Tip belirterek

```dart
int yas = 25;
double boy = 1.75;
String isim = "Ahmet";
bool ogrenciMi = true;
```

### Yöntem 2: `var` ile (tip çıkarımı — type inference)

Dart, sağ taraftaki değere bakarak tipi **otomatik anlar**.

```dart
var yas = 25;        // Dart bunu int olarak anlar
var isim = "Ahmet";  // Dart bunu String olarak anlar
var boy = 1.75;      // Dart bunu double olarak anlar
```

> **Not:** `var` ile tanımlandıktan sonra farklı bir tipe değer atanamaz!
> ```dart
> var yas = 25;
> yas = "yirmi beş"; // HATA! int tipine String atanamaz
> ```

---

## 4. `final` ve `const` — Değişmez Değerler

### `final` — Çalışma zamanında atanır, sonra değiştirilemez

```dart
final String kullaniciAdi = "ahmet123";
kullaniciAdi = "mehmet"; // HATA! final değiştirilemez

// final'ı başlangıçta atamak zorunda değilsiniz:
final DateTime simdi = DateTime.now(); // Çalışma zamanında belirlenir ✓
```

### `const` — Derleme zamanında bilinen sabit değerler

```dart
const double pi = 3.14159;
const int maksimumDeneme = 3;

// const, çalışma zamanında hesaplanan değerleri kabul etmez:
const DateTime simdi = DateTime.now(); // HATA! DateTime.now() runtime'da hesaplanır
```

### Özet Tablo

| | `var` | `final` | `const` |
|--|-------|---------|---------|
| Değiştirilebilir mi? | ✅ Evet | ❌ Hayır | ❌ Hayır |
| Ne zaman atanır? | İstediğinde | Bir kez (runtime) | Derleme zamanı |
| Kullanım amacı | Genel değişken | Değişmeyecek değer | Sabit/magic number |

**Altın Kural:** Önce `const` dene → olmuyorsa `final` → olmuyorsa `var`

---

## 5. String İşlemleri

### String Tanımlama

```dart
String tekTirnak = 'Merhaba';
String ciftTirnak = "Dünya";

// Çok satırlı String (üç tırnak)
String uzunMetin = '''
Bu bir
çok satırlı
metindir.
''';
```

### String İnterpolasyon ($)

Değişkenleri String içinde kullanmak için `$` işareti kullanılır:

```dart
String isim = "Ayşe";
int yas = 22;

print("Merhaba, ben $isim");             // Merhaba, ben Ayşe
print("$isim $yas yaşındadır");          // Ayşe 22 yaşındadır
print("Gelecek yıl ${yas + 1} olacak"); // Gelecek yıl 23 olacak
```

> **Not:** Basit değişkenler için `$degisken`, ifadeler için `${ifade}` kullanın.

### Yararlı String Özellikleri

```dart
String metin = "Flutter Öğreniyorum";

print(metin.length);          // 19
print(metin.toUpperCase());   // FLUTTER ÖĞRENIYORUM
print(metin.toLowerCase());   // flutter öğreniyorum
print(metin.contains("Dart")); // false
print(metin.startsWith("Flutter")); // true
print(metin.replaceAll("Flutter", "Dart")); // Dart Öğreniyorum
```

---

## 6. Sayısal İşlemler

```dart
int a = 10;
int b = 3;

print(a + b);   // 13  — Toplama
print(a - b);   // 7   — Çıkarma
print(a * b);   // 30  — Çarpma
print(a / b);   // 3.3333... — Bölme (double döner)
print(a ~/ b);  // 3   — Tam sayı bölme
print(a % b);   // 1   — Mod (kalan)
print(a.abs()); // 10  — Mutlak değer

// Dart'ta Math işlemleri
import 'dart:math';
print(sqrt(16));  // 4.0
print(pow(2, 8)); // 256
print(max(5, 9)); // 9
```

---

## 7. Tip Dönüşümleri

```dart
// String → int
String sayi = "42";
int tamSayi = int.parse(sayi);
print(tamSayi + 1); // 43

// String → double
String ondalik = "3.14";
double piSayisi = double.parse(ondalik);

// int → String
int deger = 100;
String metin = deger.toString();
print("Değer: $metin"); // Değer: 100

// int → double
int tamSayi2 = 5;
double ondalik2 = tamSayi2.toDouble(); // 5.0

// double → int (ondalık kısım kesilir)
double ondalik3 = 7.9;
int tamSayi3 = ondalik3.toInt(); // 7 (yuvarlanmaz, kesilir)
```

---

## 8. `dynamic` ve `Object` — Dikkatli Kullan!

```dart
// dynamic: tip kontrolü yok, runtime hatası alabilirsin
dynamic hersey = "metin";
hersey = 42;        // Geçerli ama tehlikeli
hersey = true;      // Geçerli

// Neden tehlikeli?
dynamic x = "merhaba";
print(x.length);    // 7 — çalışır
x = 42;
print(x.length);    // RUNTIME HATASI! int'in length'i yok
```

> **Kural:** `dynamic`'ten kaçının. Sadece gerçekten gerektiğinde kullanın.

---

## Özet

```
Değişken türleri:
├── var      → Tip çıkarımı, değiştirilebilir
├── final    → Bir kez atanır (runtime)
├── const    → Derleme zamanı sabiti
└── dynamic  → Tip yok (kaçının!)

Temel tipler:
├── int      → Tam sayı
├── double   → Ondalıklı sayı
├── String   → Metin
├── bool     → true / false
└── dynamic  → Herhangi bir şey
```

---

## Alıştırmalar

> Aşağıdaki alıştırmaları `ornekler/alistirma.dart` dosyasını oluşturarak yapın.

1. Kendinizin adını, soyadını, yaşınızı ve boyunuzu değişkenlerde saklayın ve ekrana yazdırın.
2. İki sayıyı toplayıp sonucu "Sonuç: X" formatında yazdırın.
3. `"Flutter Eğitimi"` stringini önce büyük harfe, sonra küçük harfe çevirin.
4. `"25"` ve `"17"` string değerlerini alın, int'e çevirin ve toplamını yazdırın.
5. `pi` sabitini `const` olarak tanımlayın ve `r=5` olan dairenin alanını hesaplayın.

---

**Sonraki Ders:** [Ders 02 — Kontrol Akışı (if, for, while, switch)](../Ders02_Kontrol_Akisi/ders_notu.md)
