# Ders 06 — Null Safety

## Bu Derste Neler Öğreneceğiz?
- Null nedir ve neden tehlikelidir?
- Dart'ın Null Safety sistemi
- `?` ile nullable tipler
- `!` operatörü (null assertion)
- `??` (null coalescing) ve `?.` (null-aware access)
- `late` anahtar kelimesi
- Null safety ile çalışma örüntüleri

---

## 1. Null Nedir ve Neden Sorun Çıkarır?

`null`, "değer yok" veya "tanımsız" anlamına gelir.

**Null Safety olmadan (tehlikeli):**
```dart
// Eski Dart:
String isim = null;         // Geçerliydi
print(isim.length);         // CRASH! NullPointerException
```

> Tony Hoare (null'ı icat eden kişi), buna "Milyar dolarlık hata" dedi.

**Dart'ın çözümü:** Derleme zamanında null hatalarını yakala!

---

## 2. Nullable (`?`) ve Non-nullable Tipler

```dart
// Non-nullable (null olamaz — güvenli)
String isim = "Ahmet";     // ✅
String isim2 = null;       // ❌ DERLEME HATASI

// Nullable (null olabilir — dikkatli kullan)
String? sehir = null;      // ✅ ? ile null olabilir
String? sehir2 = "İstanbul"; // ✅ Değer de alabilir
```

### Tüm tipler nullable olabilir

```dart
int? sayi = null;
double? ondalik = null;
bool? bayrak = null;
List<String>? liste = null;
Ogrenci? ogrenci = null;
```

---

## 3. Nullable Değerlerle Çalışmak

### `?.` — Null-aware access (güvenli erişim)

Nesne null ise hata vermek yerine `null` döndürür:

```dart
String? isim = null;

// Tehlikeli:
// print(isim.length); // CRASH!

// Güvenli:
print(isim?.length);  // null (hata vermez)

// Zincir:
String? email = kullanici?.iletisim?.email;
```

### `??` — Null coalescing (null birleştirme)

Eğer değer null ise alternatif değeri kullan:

```dart
String? kullaniciAdi = null;

// Kısa yol:
String gosterilecekAd = kullaniciAdi ?? "Misafir";
print(gosterilecekAd); // Misafir

// Birden fazla:
String? a = null;
String? b = null;
String c = a ?? b ?? "Varsayılan"; // Varsayılan
```

### `??=` — Null varsa ata

```dart
String? cache;

cache ??= "İlk değer"; // null ise ata
print(cache);           // İlk değer

cache ??= "İkinci değer"; // artık null değil, atanmaz
print(cache);             // İlk değer
```

### `!` — Null assertion (null olmadığını söyle)

Değerin null olmadığından EMİNSENİZ kullanın. Yanlış kullanım crash'e yol açar!

```dart
String? isim = "Ahmet";

// isim'in null olmadığından eminiz:
int uzunluk = isim!.length;
print(uzunluk); // 5

// DİKKAT: Gerçekten null ise crash olur:
String? bos = null;
// int uzunluk2 = bos!.length; // RUNTIME CRASH!
```

> **Kural:** `!` operatörünü mümkün olduğunca az kullanın. Genellikle daha iyi bir yol vardır.

---

## 4. Null Güvenliği ile Kod Yazmak

### if ile kontrol

```dart
String? email = kullaniciGetir()?.email;

if (email != null) {
  // Bu blok içinde email non-nullable'dır (smart cast)
  print(email.length); // Güvenli, ? gerekmez
  print(email.toUpperCase());
}
```

### if-null ile erken dönüş

```dart
String? token = getToken();
if (token == null) {
  print("Token bulunamadı, giriş yapın");
  return;
}
// Buradan sonra token non-nullable
print("Token: ${token.substring(0, 8)}...");
```

### Koleksiyonlarda null

```dart
List<String?> liste = ["Ahmet", null, "Zeynep", null, "Ali"];

// Null olanları filtrele:
List<String> temizListe = liste.whereType<String>().toList();
print(temizListe); // [Ahmet, Zeynep, Ali]

// Null ise boş string yap:
List<String> varsayilanli = liste.map((e) => e ?? "Bilinmiyor").toList();
```

---

## 5. `late` — Geç Başlatma

Değişkeni tanımlarken değer vermek mümkün değilse `late` kullanılır:

```dart
class Kullanici {
  late String isim;    // Başlangıçta atanmaz
  late int yas;

  void yukle(String ad, int y) {
    isim = ad;  // Sonradan atanır
    yas = y;
  }

  void yazdir() {
    print("$isim: $yas"); // Eğer atanmadıysa LateInitializationError!
  }
}
```

### `late final` — Bir kez atanan geç değer

```dart
class Veritabani {
  late final String baglantıStringi;

  void baglaN(String host, int port) {
    // Yalnızca bir kez atanabilir:
    baglantıStringi = "$host:$port";
  }
}
```

> **Dikkat:** `late` değişkene erişmeden önce atanmamışsa `LateInitializationError` alırsınız.

---

## 6. required ile Null Safety

Named parametreler varsayılan olarak nullable'dır. `required` ile zorunlu yapın:

```dart
// Kötü: Her parametre nullable
void kullanicıOlustur({String? isim, int? yas}) {
  print("$isim: $yas"); // Hem isim hem yas null olabilir
}

// İyi: required ile zorunlu
void kullanicıOlustur2({required String isim, required int yas}) {
  print("$isim: $yas"); // Garantili olarak non-null
}

// Çağırma:
kullanicıOlustur2(isim: "Ahmet", yas: 25); // ✅
// kullanicıOlustur2(isim: "Ahmet");        // ❌ yas zorunlu!
```

---

## 7. Null Safety Örüntüleri

### Güvenli navigasyon zinciri

```dart
class Adres {
  String? sehir;
  String? ilce;
}

class Kullanici {
  String isim;
  Adres? adres;
  Kullanici(this.isim);
}

Kullanici? kullanici = getirKullanici();

// Güvenli zincir:
String sehir = kullanici?.adres?.sehir ?? "Bilinmiyor";
print(sehir);
```

### Tip dönüşümü + null safety

```dart
dynamic deger = getirDeger(); // dynamic tipte geliyor

// Güvenli cast:
String? metin = deger is String ? deger : null;
int? sayi = deger is int ? deger : null;

// Ya da:
String? metin2 = deger as String?; // null ise null döner, yanlış tip ise crash
```

---

## Özet

```
Null Safety operatörleri:
├── ?     → Nullable tip tanımı  (String?)
├── ?.    → Null-aware access    (obj?.field)
├── ??    → Null coalescing      (a ?? "default")
├── ??=   → Null-aware assign    (a ??= "value")
├── !     → Null assertion       (obj!.field) ← dikkatli!
└── late  → Geç başlatma

Güvenli kodlama:
├── Mümkünse non-nullable kullan
├── ! yerine if veya ?? tercih et
├── late'i sadece gerektiğinde kullan
└── required parametrelerle null'ı önle
```

---

## Alıştırmalar

1. Nullable String alan, null ise "Bilinmiyor" döndüren `guvenliGoster()` fonksiyonu yazın.
2. `Kullanici` sınıfı oluşturun: zorunlu `isim`, isteğe bağlı `telefon`, `email` alanları. `iletisim()` metodu null olanları "belirtilmemiş" göstersin.
3. `List<int?>` alıp null'ları filtreleyerek toplamını döndüren fonksiyon yazın.
4. `late` kullanarak bir sınıf oluşturun ve başlatma sırasını gösterin.
5. `??` zinciri kullanarak birden fazla nullable değerden ilk non-null olanı döndürün.

---

**Önceki Ders:** [Ders 05 — OOP](../Ders05_OOP_Siniflar/ders_notu.md)
**Sonraki Ders:** [Ders 07 — Asenkron Programlama Temelleri](../Ders07_Asenkron_Temelleri/ders_notu.md)
