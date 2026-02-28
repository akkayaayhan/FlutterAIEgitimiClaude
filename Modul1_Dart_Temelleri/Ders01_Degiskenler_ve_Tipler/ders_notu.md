# Ders 01 — Değişkenler ve Veri Tipleri

## Bu Derste Neler Öğreneceğiz?
- Dart'ta değişken nedir, nasıl tanımlanır?
- Temel veri tipleri nelerdir?
- `var`, `final`, `const` arasındaki fark
- Tip dönüşümleri
- String interpolasyon

---

## 1. Değişken Nedir?

Değişken, bir değeri saklamak için kullandığımız isimli bir **"kutu"**dur. Programlama dünyasında her veri bir yerde tutulmalıdır — işte değişkenler bu depoların adresli kutularıdır.

Bir değişken oluşturduğunuzda aslında bilgisayarın belleğinde (RAM) bir alan ayrılır ve o alana bir isim verilir. Bu isim sayesinde değere istediğiniz zaman erişebilir, değiştirebilir veya kullanabilirsiniz.

```
┌─────────────────────┐
│  isim = "Ahmet"     │  ← Bir String değeri saklıyor
└─────────────────────┘

┌─────────────────────┐
│  yas = 25           │  ← Bir int değeri saklıyor
└─────────────────────┘
```

### Değişken İsimlendirme Kuralları

Dart'ta değişken isimlendirirken uyulması gereken kurallar vardır:

```dart
// ✅ Geçerli isimlendirmeler
int yas = 25;
String kullaniciAdi = "ahmet";
double toplamFiyat = 99.90;
bool _aktifMi = true;           // Alt çizgi ile başlayabilir
int sayi1 = 10;                 // Rakam içerebilir (ama başta olamaz)

// ❌ Geçersiz isimlendirmeler
// int 1sayi = 10;              // Rakamla başlayamaz!
// String kullanıcı-adı = "";   // Tire (-) kullanılamaz!
// bool class = true;           // Dart anahtar kelimeleri (reserved words) kullanılamaz!
// double toplam fiyat = 0;     // Boşluk içeremez!
```

> **Best Practice — camelCase:** Dart'ta değişken isimleri `camelCase` formatında yazılır. İlk kelime küçük harfle başlar, sonraki kelimelerin baş harfleri büyük olur: `kullaniciAdi`, `toplamFiyat`, `ogrenciNumarasi` gibi. Bu, Dart topluluğunun standart bir kuralıdır ve kodunuzun okunabilirliğini büyük ölçüde artırır.

---

## 2. Dart'ta Temel Veri Tipleri

Dart, **statik tipli** (statically typed) bir dildir. Bu, her değişkenin bir tipi olduğu ve bu tipin derleme zamanında (compile time) kontrol edildiği anlamına gelir. Yanlış tipe bir değer atamaya çalışırsanız, daha programınız çalışmadan hata alırsınız — bu da hataları erken yakalamanızı sağlar.

| Tip | Açıklama | Bellekte | Örnek |
|-----|----------|----------|-------|
| `int` | Tam sayı. Pozitif, negatif veya sıfır olabilir. Ondalık kısmı yoktur. | 64-bit | `42`, `-10`, `0` |
| `double` | Ondalıklı (kayan noktalı) sayı. Hassas hesaplamalar için kullanılır. | 64-bit | `3.14`, `-0.5`, `1.0` |
| `String` | Metin verisi. Tek veya çift tırnak ile tanımlanır. | Uzunluğa göre değişir | `"Merhaba"`, `'Dart'` |
| `bool` | Mantıksal (boolean) değer. Sadece iki değer alabilir: doğru ya da yanlış. | 1-bit | `true`, `false` |
| `num` | `int` ve `double`'ın üst tipi. Her iki sayı tipini de kabul eder. | — | `42` veya `3.14` |
| `dynamic` | Herhangi bir tip olabilir, tip güvenliği kaybedilir. **Kaçının!** | — | `"metin"` veya `42` |

### Her Tipin Detaylı Açıklaması

#### `int` — Tam Sayılar

Tam sayılar, ondalık kısmı olmayan sayılardır. Genellikle sayaçlar, indeksler, ID değerleri ve yaş gibi tam sayı gerektiren durumlarda kullanılır.

```dart
int yas = 25;
int sicaklik = -5;           // Negatif olabilir
int nufus = 84000000;        // Büyük sayılar
int hexDeger = 0xFF;          // Hexadecimal (onaltılık) gösterim → 255
```

#### `double` — Ondalıklı Sayılar

Ondalık kısım içeren sayılardır. Fiyatlar, ölçümler, koordinatlar ve bilimsel hesaplamalarda kullanılır. Dart'ta `/` (bölme) operatörü her zaman `double` döndürür.

```dart
double boy = 1.75;
double pi = 3.14159;
double sicaklik = -2.5;
double kucukSayi = 1.5e-3;   // Bilimsel gösterim → 0.0015
```

> **Dikkat:** `double` tipi kayan nokta aritmetiği kullanır. Bu nedenle `0.1 + 0.2`, tam olarak `0.3` olmayabilir (`0.30000000000000004` gibi bir sonuç verebilir). Para hesaplamalarında `int` (kuruş cinsinden) kullanmayı tercih edin.

#### `String` — Metin

Metin verilerini saklamak için kullanılır. Tek tırnak (`'...'`) veya çift tırnak (`"..."`) ile tanımlanabilir — Dart'ta ikisi arasında teknik bir fark yoktur.

```dart
String ad = "Ahmet";
String soyad = 'Yılmaz';
String bos = "";              // Boş string geçerlidir
String emoji = "🎯 Dart";    // Emoji ve Unicode desteklenir
```

#### `bool` — Mantıksal Değer

Sadece `true` (doğru) veya `false` (yanlış) değer alır. Koşul ifadelerinde, döngülerde ve mantıksal karşılaştırmalarda kullanılır. İsimlendirirken genellikle `mi/mu`, `is/has` gibi soru yapılarıyla isimlendirilir.

```dart
bool girisYapildiMi = false;
bool aktif = true;
bool yetiskin = (yas >= 18);  // Karşılaştırma sonucu bool döner
```

---

## 3. Değişken Tanımlama

Dart'ta değişken tanımlamanın birden fazla yolu vardır. Hangi yolu seçeceğiniz, duruma ve kodunuzun okunabilirliğine bağlıdır.

### Yöntem 1: Tip belirterek (Explicit Type)

Değişkenin tipini açıkça yazarsınız. Bu yöntem, kodun ne yaptığını daha açık hale getirir ve özellikle başlangıç seviyesinde öğrenme aşamasında tavsiye edilir.

```dart
int yas = 25;
double boy = 1.75;
String isim = "Ahmet";
bool ogrenciMi = true;
```

Bu yaklaşımın avantajı, kodu okuyan herkesin değişkenin tipini ilk bakışta görebilmesidir.

### Yöntem 2: `var` ile (Tip Çıkarımı — Type Inference)

Dart, atanan değere bakarak değişkenin tipini **otomatik olarak çıkarır**. Tip açıkça yazılmaz, ancak arka planda Dart yine de o değişkene bir tip atar. Yani `var` ile tanımlanan bir değişken "tipsiz" değildir!

```dart
var yas = 25;        // Dart bunu int olarak anlar
var isim = "Ahmet";  // Dart bunu String olarak anlar
var boy = 1.75;      // Dart bunu double olarak anlar
var aktif = true;    // Dart bunu bool olarak anlar
```

> **Önemli:** `var` ile tanımlandıktan sonra, değişkenin tipi kesinleşir ve artık farklı bir tipe değer atanamaz! Bu, Dart'ın **tip güvenliği** (type safety) mekanizmasının bir parçasıdır.
>
> ```dart
> var yas = 25;
> yas = 30;              // ✅ Geçerli — yine int
> yas = "yirmi beş";     // ❌ HATA! int tipine String atanamaz
> ```

### Yöntem 3: Tip belirterek ama değer atamadan (Late Initialization)

Bazen değişkeni tanımlarken henüz bir değer atayamayabilirsiniz. Bu durumda değişken, varsayılan olarak `null` değeri alır — ama bunun için `?` ile nullable yapmalısınız:

```dart
int? yas;               // Değer atanmadı, şu an null
print(yas);             // null
yas = 25;               // Sonradan değer atandı
print(yas);             // 25

// late anahtar kelimesi ile (null olmadan):
late String isim;       // Değer atanmadan kullanılamaz
isim = "Ahmet";         // Kullanmadan önce atanmalı!
print(isim);            // Ahmet
```

---

## 4. `final` ve `const` — Değişmez Değerler

Bazı durumlarda bir değişkenin değerinin **asla değişmemesini** isteriz. Örneğin, bir kullanıcının doğum tarihi, matematiksel sabitler (π, e), veya bir API anahtarı gibi değerler programın çalışması boyunca sabit kalmalıdır. İşte bu durumlarda `final` ve `const` devreye girer.

### `final` — Çalışma Zamanında Bir Kez Atanır, Sonra Değiştirilemez

`final` ile tanımlanan bir değişken, **çalışma zamanında** (runtime) bir kez değer alır ve bir daha değiştirilemez. Değer, programın çalışma anında hesaplanabilir — bu onun `const`'tan temel farkıdır.

```dart
final String kullaniciAdi = "ahmet123";
kullaniciAdi = "mehmet"; // ❌ HATA! final bir kez atandıktan sonra değiştirilemez

// final, runtime'da hesaplanan değerleri kabul eder:
final DateTime simdi = DateTime.now(); // ✅ Çalışma zamanında belirlenir
final int rastgele = Random().nextInt(100); // ✅ Her çalışmada farklı değer

// Tip belirtmeden de kullanılabilir:
final isim = "Ahmet";   // Dart tipi otomatik çıkarır (String)
```

**Ne zaman `final` kullanmalı?**
- Bir API'den gelen ve sonradan değişmeyecek veriler
- Kullanıcının giriş yaptıktan sonra değişmeyen bilgileri
- `DateTime.now()` gibi runtime'da hesaplanan ama sonra sabit kalacak değerler
- Flutter'da `Widget`'lerin `key` parametresi

### `const` — Derleme Zamanında Bilinen Sabit Değerler

`const` ile tanımlanan bir değişken, **derleme zamanında** (compile time) değerinin bilinmesi gerekir. Bu, program daha çalışmadan önce değerin belli olduğu anlamına gelir. `const` değerler bellekte sadece bir kez oluşturulur ve paylaşılır — bu da performans avantajı sağlar.

```dart
const double pi = 3.14159;
const int maksimumDeneme = 3;
const String uygulamaAdi = "Flutter Eğitim";

// const, çalışma zamanında hesaplanan değerleri kabul etmez:
const DateTime simdi = DateTime.now(); // ❌ HATA! DateTime.now() runtime'da hesaplanır

// const ifadeler birbirine bağlanabilir:
const double ikiPi = 2 * pi; // ✅ Geçerli — iki const'un çarpımı yine const
```

**Ne zaman `const` kullanmalı?**
- Matematiksel sabitler (`pi`, `e`, `maxInt` vb.)
- Uygulama genelinde değişmeyecek yapılandırma değerleri
- Magic number'ları ortadan kaldırmak için (`const int maksDenemeSayisi = 3;`)
- Flutter'da değişmeyen widget'ler (`const Text("Merhaba")`)

### Özet Tablo

| | `var` | `final` | `const` |
|--|-------|---------|---------|
| Değiştirilebilir mi? | ✅ Evet | ❌ Hayır | ❌ Hayır |
| Ne zaman atanır? | İstediğin zaman | Bir kez (runtime) | Derleme zamanı |
| Runtime değer kabul eder mi? | ✅ Evet | ✅ Evet | ❌ Hayır |
| Kullanım amacı | Değişebilecek değerler | Bir kez atanıp değişmeyecek değer | Sabit / magic number |
| Performans | Normal | Normal | En iyi (bellekte paylaşılır) |

**Altın Kural:** Önce `const` dene → olmuyorsa `final` → olmuyorsa `var`

Bu kural, mümkün olan en katı kısıtlamayı tercih etmenizi sağlar. Bu sayede yanlışlıkla değiştirilmemesi gereken değerleri korursunuz ve derleyici daha fazla optimizasyon yapabilir.

---

## 5. String İşlemleri

String, programlamada en sık kullanılan veri tiplerinden biridir. Kullanıcıya mesaj göstermek, veri formatlamak, dosya yollarını oluşturmak — hepsi String işlemleriyle yapılır.

### String Tanımlama

Dart'ta String tanımlamak için tek tırnak veya çift tırnak kullanabilirsiniz. İkisi arasında işlevsel bir fark yoktur, ancak bir projenin içinde tutarlı olmak önemlidir.

```dart
String tekTirnak = 'Merhaba';
String ciftTirnak = "Dünya";

// İç içe tırnak kullanımı:
String mesaj1 = "O'nun evi";            // Çift tırnak içinde tek tırnak
String mesaj2 = 'Ahmet "merhaba" dedi'; // Tek tırnak içinde çift tırnak
String mesaj3 = 'O\'nun evi';           // Escape karakteri (\) ile

// Çok satırlı String (üç tırnak)
String uzunMetin = '''
Bu bir
çok satırlı
metindir.
''';

// Ham (raw) String — escape karakterleri işlenmez
String dosyaYolu = r'C:\Users\Ahmet\Desktop';  // \U, \A gibi kaçış kodları çalışmaz
```

### String İnterpolasyon ($)

String interpolasyon, değişkenleri ya da ifadeleri doğrudan bir String'in içine yerleştirmenizi sağlar. Bu, String birleştirme (`+`) operatöründen çok daha okunabilir ve performanslıdır.

```dart
String isim = "Ayşe";
int yas = 22;

// String interpolasyon (önerilen yol):
print("Merhaba, ben $isim");                    // Merhaba, ben Ayşe
print("$isim $yas yaşındadır");                 // Ayşe 22 yaşındadır
print("Gelecek yıl ${yas + 1} olacak");         // Gelecek yıl 23 olacak

// String birleştirme (+ ile — interpolasyona göre daha zahmetli):
print("Merhaba, ben " + isim);                  // Merhaba, ben Ayşe
print(isim + " " + yas.toString() + " yaşındadır"); // Ayşe 22 yaşındadır — toString() gerekir!
```

> **Not:** Basit değişkenler için `$degisken`, ifadeler (toplama, fonksiyon çağrısı vb.) için `${ifade}` kullanın. `+` ile birleştirmekten kaçının çünkü hem daha yavaştır hem de `int` gibi String olmayan tipleri önce `toString()` ile dönüştürmeniz gerekir.

### Yararlı String Metotları

Dart'ın `String` sınıfı pek çok hazır metot sunar. İşte en çok kullanılanlar:

```dart
String metin = "Flutter Öğreniyorum";

// Bilgi alma
print(metin.length);                         // 19 — karakter sayısı
print(metin.isEmpty);                        // false — boş mu?
print(metin.isNotEmpty);                     // true — dolu mu?

// Dönüştürme
print(metin.toUpperCase());                  // FLUTTER ÖĞRENIYORUM
print(metin.toLowerCase());                  // flutter öğreniyorum

// Arama
print(metin.contains("Dart"));               // false — "Dart" var mı?
print(metin.startsWith("Flutter"));           // true — "Flutter" ile başlıyor mu?
print(metin.endsWith("rum"));                // true — "rum" ile bitiyor mu?
print(metin.indexOf("Öğ"));                  // 8 — "Öğ" kaçıncı indekste?

// Değiştirme
print(metin.replaceAll("Flutter", "Dart"));  // Dart Öğreniyorum
print(metin.trim());                         // Baştaki ve sondaki boşlukları siler

// Parçalama
print(metin.substring(0, 7));                // Flutter — 0'dan 7'ye kadar kes
print(metin.split(" "));                     // [Flutter, Öğreniyorum] — boşluktan böl
```

---

## 6. Sayısal İşlemler

Dart'ta sayılarla çalışırken temel aritmetik operatörlerin yanı sıra, `dart:math` kütüphanesi ile daha gelişmiş matematiksel işlemler yapabilirsiniz.

### Temel Aritmetik Operatörler

```dart
int a = 10;
int b = 3;

print(a + b);   // 13   — Toplama
print(a - b);   // 7    — Çıkarma
print(a * b);   // 30   — Çarpma
print(a / b);   // 3.33 — Bölme (her zaman double döner!)
print(a ~/ b);  // 3    — Tam sayı bölme (ondalık kısmı atar)
print(a % b);   // 1    — Mod (kalan) operatörü
```

> **Dikkat:** `/` operatörü Dart'ta **her zaman `double` döndürür**, iki `int` bölseniz bile! Tam sayı sonuç istiyorsanız `~/` operatörünü kullanın.

### Atama Operatörleri

Kısayol operatörleri, değişkenin mevcut değerini kullanarak yeni değer atamanızı sağlar:

```dart
int sayac = 10;

sayac += 5;    // sayac = sayac + 5  → 15
sayac -= 3;    // sayac = sayac - 3  → 12
sayac *= 2;    // sayac = sayac * 2  → 24
sayac ~/= 4;   // sayac = sayac ~/ 4 → 6
sayac %= 4;    // sayac = sayac % 4  → 2

// Artırma / Azaltma
sayac++;        // sayac = sayac + 1  → 3
sayac--;        // sayac = sayac - 1  → 2
```

### Karşılaştırma Operatörleri

Karşılaştırma operatörleri her zaman `bool` (true/false) döndürür:

```dart
int x = 10;
int y = 20;

print(x == y);   // false — Eşit mi?
print(x != y);   // true  — Eşit değil mi?
print(x > y);    // false — Büyük mü?
print(x < y);    // true  — Küçük mü?
print(x >= 10);  // true  — Büyük veya eşit mi?
print(x <= 5);   // false — Küçük veya eşit mi?
```

### Sayılarda Yararlı Metotlar

```dart
int sayi = -7;
print(sayi.abs());       // 7 — Mutlak değer
print(sayi.isNegative);  // true — Negatif mi?
print(sayi.sign);        // -1 — İşaret (1, 0, veya -1)

double ondalik = 3.7;
print(ondalik.round());  // 4 — En yakın tam sayıya yuvarla
print(ondalik.ceil());   // 4 — Yukarı yuvarla
print(ondalik.floor());  // 3 — Aşağı yuvarla
```

### `dart:math` Kütüphanesi

Daha gelişmiş matematiksel işlemler için `dart:math` kütüphanesini import etmeniz gerekir:

```dart
import 'dart:math';

print(sqrt(16));     // 4.0 — Karekök
print(pow(2, 8));    // 256 — Üs alma (2⁸)
print(max(5, 9));    // 9   — İki sayının büyüğü
print(min(5, 9));    // 5   — İki sayının küçüğü
print(pi);           // 3.141592653589793 — π sabiti (math kütüphanesinden)
print(e);            // 2.718281828459045 — Euler sabiti
```

---

## 7. Tip Dönüşümleri

Farklı veri tipleri arasında dönüşüm yapmak, özellikle kullanıcıdan alınan verilerle çalışırken çok önemlidir. Kullanıcı bir `TextField`'a metin girer (String), ama siz bu değerle matematik yapmanız gerekebilir (int/double). İşte bu noktada tip dönüşümleri devreye girer.

### String → int

```dart
String sayi = "42";
int tamSayi = int.parse(sayi);
print(tamSayi + 1); // 43

// Geçersiz giriş kontrolü (tryParse güvenli yöntemdir):
int? sonuc = int.tryParse("merhaba");
print(sonuc); // null — dönüşüm başarısız olursa null döner, hata fırlatmaz

// Güvenli kullanım:
String kullaniciGirisi = "abc";
int deger = int.tryParse(kullaniciGirisi) ?? 0; // null ise 0 kullan
print(deger); // 0
```

### String → double

```dart
String ondalik = "3.14";
double piSayisi = double.parse(ondalik);
print(piSayisi); // 3.14

// Güvenli dönüşüm:
double? sonuc = double.tryParse("xyz");
print(sonuc); // null
```

### int → String

```dart
int deger = 100;
String metin = deger.toString();
print("Değer: $metin"); // Değer: 100

// padLeft ile formatlama:
int saat = 9;
print(saat.toString().padLeft(2, '0')); // "09" — soldan 0 ile doldur
```

### int ↔ double

```dart
// int → double
int tamSayi = 5;
double ondalik = tamSayi.toDouble(); // 5.0

// double → int (DİKKAT: ondalık kısım kesilir, yuvarlanmaz!)
double ondalik2 = 7.9;
int tamSayi2 = ondalik2.toInt(); // 7 — .9 kesildi!

// Yuvarlayarak dönüştürmek isterseniz:
int yuvarlanmis = ondalik2.round(); // 8 — en yakın tam sayıya
int yukari = ondalik2.ceil();       // 8 — yukarı
int asagi = ondalik2.floor();       // 7 — aşağı
```

> **Dikkat:** `toInt()` ondalık kısmi **keser**, **yuvarlamaz**! `7.9.toInt()` sonucu `7`'dir, `8` değil. Yuvarlama istiyorsanız `.round()` kullanın.

### Tip Kontrol Operatörleri

Bir değişkenin tipini kontrol etmek veya dönüştürmek (cast) için `is` ve `as` operatörlerini kullanabilirsiniz:

```dart
dynamic deger = "Merhaba";

// Tip kontrolü
if (deger is String) {
  print("Bu bir String: $deger");
  print("Uzunluğu: ${deger.length}"); // Dart otomatik olarak String gibi davranır
}

if (deger is! int) {
  print("Bu bir int değil!");
}

// Tip dönüştürme (casting) — dikkatli kullanın!
// Object obj = "test";
// String str = obj as String; // ✅ Geçerli — obj zaten String
// int sayi = obj as int;      // ❌ RUNTIME HATASI!
```

---

## 8. `dynamic` ve `Object` — Dikkatli Kullan!

### `dynamic` — Tip Kontrolü Yok

`dynamic` ile tanımlanan bir değişken, herhangi bir tipe değer alabilir ve tipi çalışma zamanında değiştirilebilir. Ancak bu, Dart'ın sunduğu tip güvenliğini tamamen devre dışı bırakır. Derleyici size yardım edemez ve hatalar ancak program çalışırken ortaya çıkar.

```dart
// dynamic: tip kontrolü yok, runtime hatası alabilirsin
dynamic hersey = "metin";
hersey = 42;        // ✅ Geçerli ama tehlikeli
hersey = true;      // ✅ Geçerli
hersey = [1, 2, 3]; // ✅ Liste bile olabilir

// Neden tehlikeli?
dynamic x = "merhaba";
print(x.length);    // 7 — çalışır çünkü String'in length'i var
x = 42;
print(x.length);    // ❌ RUNTIME HATASI! int'in length özelliği yok
                     // Derleyici bu hatayı yakalayamaz!
```

### `Object` — Tip Güvenli Alternatif

`Object`, Dart'ta tüm tiplerin üst sınıfıdır (null hariç). `dynamic`'ten farkı, derleyicinin metot çağrılarını kontrol edebilmesidir:

```dart
Object obj = "merhaba";
// print(obj.length); // ❌ DERLEME HATASI — Object'in length'i yok
                       // Bu hata daha programı çalıştırmadan yakalanır!

// Güvenli kullanım — tip kontrolü ile:
if (obj is String) {
  print(obj.length); // ✅ Artık Dart bunun String olduğunu biliyor
}
```

> **Kural:** `dynamic`'ten mümkün olduğunca kaçının. Eğer farklı tipleri kabul etmesi gereken bir değişkene ihtiyacınız varsa, `Object` kullanın ve `is` ile tip kontrolü yapın. `dynamic` sadece JSON parse etme veya bazı kütüphane entegrasyonları gibi zorunlu durumlarda kullanılmalıdır.

### `var` vs `dynamic` — Karıştırmayın!

Bu ikisi sıkça karıştırılır ama temelden farklıdırlar:

```dart
var a = "merhaba";   // Dart tipi String olarak çıkarır
// a = 42;           // ❌ HATA — a artık String, başka tip atanamaz

dynamic b = "merhaba"; // Tip kontrolü yok
b = 42;                // ✅ Geçerli — ama tehlikeli!
b = true;              // ✅ Geçerli — ama daha da tehlikeli!
```

---

## 9. Null Safety — Dart'ın Güvenlik Kalkanı

Dart 2.12 ile gelen **null safety**, değişkenlerin varsayılan olarak `null` olamayacağını garanti eder. Bu, "Null Pointer Exception" (NullPointerException) hatalarını — programlamadaki en yaygın hata türlerinden birini — büyük ölçüde önler.

```dart
// Non-nullable (varsayılan — null olamaz):
String isim = "Ahmet";
// isim = null; // ❌ HATA! String tipine null atanamaz

// Nullable (? ile — null olabilir):
String? soyad;          // Değer atanmadı, şu an null
print(soyad);           // null
soyad = "Yılmaz";       // Daha sonra atanabilir
print(soyad);           // Yılmaz

// Null kontrolü:
String? ad = null;
print(ad?.length);       // null — hata vermez (? ile güvenli erişim)
print(ad?.toUpperCase() ?? "İsim yok"); // "İsim yok" — null ise alternatif değer

// ! operatörü (Null assertion — "kesinlikle null değil" demek):
String? sehir = "İstanbul";
String kesinSehir = sehir!; // ✅ Geçerli — ama sehir null ise runtime hatası!
```

> **Önemli Operatörler:**
> - `?` → Bu değişken null olabilir
> - `?.` → Null ise metodu çağırma, null döndür
> - `??` → Null ise alternatif değeri kullan
> - `!` → "Bu kesinlikle null değil" (dikkatli kullanın!)

---

## Özet

```
Değişken türleri:
├── var      → Tip çıkarımı, değiştirilebilir (ama tipi değişmez)
├── final    → Bir kez atanır (runtime'da), sonra değiştirilemez
├── const    → Derleme zamanı sabiti (en iyi performans)
├── late     → Gecikmeli başlatma (kullanmadan önce atanmalı)
└── dynamic  → Tip yok (kaçının!)

Temel tipler:
├── int      → Tam sayı (42, -10, 0)
├── double   → Ondalıklı sayı (3.14, -0.5)
├── String   → Metin ("Merhaba", 'Dart')
├── bool     → true / false
├── num      → int ve double'ın üst tipi
└── dynamic  → Herhangi bir şey (tip güvensiz)

Tip dönüşümleri:
├── int.parse("42")         → String → int
├── double.parse("3.14")    → String → double
├── 42.toString()           → int → String
├── 42.toDouble()           → int → double
├── 7.9.toInt()             → double → int (keser!)
├── int.tryParse("abc")     → Güvenli dönüşüm (null döner)
└── is / as                 → Tip kontrol ve cast

Null safety:
├── String    → Null olamaz
├── String?   → Null olabilir
├── ?.        → Güvenli erişim
├── ??        → Null ise alternatif
└── !         → Null olmadığını garanti et
```

---

## Alıştırmalar

> Aşağıdaki alıştırmaları `ornekler/alistirma.dart` dosyasını oluşturarak yapın.

1. Kendinizin adını, soyadını, yaşınızı ve boyunuzu değişkenlerde saklayın ve ekrana yazdırın.
2. İki sayıyı toplayıp sonucu "Sonuç: X" formatında yazdırın.
3. `"Flutter Eğitimi"` stringini önce büyük harfe, sonra küçük harfe çevirin.
4. `"25"` ve `"17"` string değerlerini alın, int'e çevirin ve toplamını yazdırın.
5. `pi` sabitini `const` olarak tanımlayın ve `r=5` olan dairenin alanını hesaplayın.
6. **Bonus:** Kullanıcıdan bir sayı string'i alın (`"123abc"` gibi), `tryParse` ile güvenli dönüşüm yapın ve sonucu ekrana yazdırın.

---

**Sonraki Ders:** [Ders 02 — Kontrol Akışı (if, for, while, switch)](../Ders02_Kontrol_Akisi/ders_notu.md)
