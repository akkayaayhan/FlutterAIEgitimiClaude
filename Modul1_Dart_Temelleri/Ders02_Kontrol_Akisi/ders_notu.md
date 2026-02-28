# Ders 02 — Kontrol Akışı

## Bu Derste Neler Öğreneceğiz?
- `if` / `else if` / `else` — Koşul yapıları
- `switch` / `case` — Çoklu koşul
- `for`, `while`, `do-while` — Döngüler
- `break` ve `continue`
- Ternary operatör (`? :`)

---

## 1. if / else — Koşullu Çalışma

Programın akışını bir koşula göre yönlendiririz.

```
Koşul doğruysa → if bloğu çalışır
Koşul yanlışsa → else bloğu çalışır
```

```dart
int yas = 18;

if (yas >= 18) {
  print("Ehliyet alabilirsin");
} else {
  print("Henüz ehliyet yaşında değilsin");
}
```

### else if — Birden Fazla Koşul

```dart
int not = 75;

if (not >= 90) {
  print("AA");
} else if (not >= 80) {
  print("BA");
} else if (not >= 70) {
  print("BB");
} else if (not >= 60) {
  print("CB");
} else {
  print("Başarısız");
}
```

### Mantıksal Operatörler

| Operatör | Anlam | Örnek |
|----------|-------|-------|
| `&&` | VE (her ikisi de doğru olmalı) | `yas >= 18 && ehliyetVar` |
| `\|\|` | VEYA (biri doğru olmalı) | `admin \|\| moderator` |
| `!` | DEĞİL (tersini alır) | `!oturumAcik` |

```dart
bool yetiskin = true;
bool ehliyetVar = false;

if (yetiskin && ehliyetVar) {
  print("Araba kullanabilir");
} else if (yetiskin && !ehliyetVar) {
  print("Yetişkin ama ehliyeti yok");
} else {
  print("Ehliyet alamaz");
}
```

---

## 2. Ternary Operatör — Kısa if/else

Tek satırda basit bir koşulu ifade etmek için:

```
koşul ? doğruysa_bu : yanlışsa_bu
```

```dart
int yas = 20;

// Uzun yol:
String durum;
if (yas >= 18) {
  durum = "Yetişkin";
} else {
  durum = "Çocuk";
}

// Kısa yol (ternary):
String durum2 = yas >= 18 ? "Yetişkin" : "Çocuk";

print(durum2); // Yetişkin
```

---

## 3. switch / case — Çoklu Seçenek

Bir değerin birden fazla olası değerine göre işlem yapmak için:

```dart
String gun = "Pazartesi";

switch (gun) {
  case "Pazartesi":
  case "Salı":
  case "Çarşamba":
  case "Perşembe":
  case "Cuma":
    print("İş günü");
    break;
  case "Cumartesi":
  case "Pazar":
    print("Hafta sonu");
    break;
  default:
    print("Geçersiz gün");
}
```

> **Not:** `break` yoksa kod bir sonraki `case`'e "düşer" (fall-through).

### Dart 3.0+ — Switch Expression (Modern Sözdizimi)

```dart
String gun = "Pazartesi";

String gunTipi = switch (gun) {
  "Pazartesi" || "Salı" || "Çarşamba" || "Perşembe" || "Cuma" => "İş günü",
  "Cumartesi" || "Pazar" => "Hafta sonu",
  _ => "Geçersiz gün",
};

print(gunTipi); // İş günü
```

---

## 4. Döngüler

### for — Belirli Sayıda Tekrar

```dart
// 1'den 5'e kadar say
for (int i = 1; i <= 5; i++) {
  print("Sayı: $i");
}
// Çıktı: Sayı: 1, Sayı: 2, ..., Sayı: 5

// Geriye doğru say
for (int i = 5; i >= 1; i--) {
  print(i);
}

// İkişer ikişer atla
for (int i = 0; i <= 10; i += 2) {
  print(i); // 0, 2, 4, 6, 8, 10
}
```

### for-in — Koleksiyonda Gezinme

```dart
List<String> meyveler = ["elma", "armut", "kiraz"];

for (String meyve in meyveler) {
  print("Meyve: $meyve");
}
```

### while — Koşul Doğru Olduğu Sürece

```dart
int sayac = 1;

while (sayac <= 5) {
  print("Sayaç: $sayac");
  sayac++; // Bunu unutursanız sonsuz döngü!
}
```

### do-while — En Az Bir Kez Çalışır

```dart
int sayi = 10;

do {
  print("Çalıştı: $sayi");
  sayi++;
} while (sayi < 5);

// sayi=10 > 5 olmasına rağmen bir kez çalışır!
// Çıktı: Çalıştı: 10
```

---

## 5. break ve continue

### break — Döngüyü Tamamen Durdur

```dart
for (int i = 1; i <= 10; i++) {
  if (i == 5) {
    print("5'e ulaşıldı, duruyorum");
    break; // Döngü burada biter
  }
  print(i);
}
// Çıktı: 1, 2, 3, 4, "5'e ulaşıldı, duruyorum"
```

### continue — Bu Turu Atla, Devam Et

```dart
for (int i = 1; i <= 10; i++) {
  if (i % 2 == 0) {
    continue; // Çift sayıları atla
  }
  print(i);
}
// Çıktı: 1, 3, 5, 7, 9 (sadece tek sayılar)
```

---

## 6. Karşılaştırma Operatörleri

| Operatör | Anlam | Örnek |
|----------|-------|-------|
| `==` | Eşit mi? | `a == b` |
| `!=` | Eşit değil mi? | `a != b` |
| `>` | Büyük mü? | `a > b` |
| `<` | Küçük mü? | `a < b` |
| `>=` | Büyük eşit mi? | `a >= b` |
| `<=` | Küçük eşit mi? | `a <= b` |

---

## Özet

```
Kontrol yapıları:
├── if/else if/else  → Koşullu çalışma
├── switch/case      → Çoklu seçenek
└── ? :              → Kısa koşul (ternary)

Döngüler:
├── for              → Sayaçlı döngü
├── for-in           → Koleksiyonda gezinme
├── while            → Koşullu döngü (başta kontrol)
└── do-while         → En az bir kez çalışan döngü

Döngü kontrolü:
├── break            → Döngüyü durdur
└── continue         → Bu turu atla
```

---

## Alıştırmalar

1. 1'den 100'e kadar olan sayılardan **3'e bölünebilenleri** ekrana yazdırın.
2. Bir öğrencinin notuna göre "AA", "BA", "BB", "CB", "CC", "DC", "DD", "FF" harfini yazdıran program yazın.
3. 1'den 10'a kadar sayıların **faktöriyellerini** hesaplayıp yazdırın.
4. Bir sayının **asal** olup olmadığını kontrol eden kod yazın.
5. FizzBuzz: 1-30 arası, 3'e bölünebilenlere "Fizz", 5'e bölünebilenlere "Buzz", her ikisine de bölünebilenlere "FizzBuzz" yazdırın.

---

**Önceki Ders:** [Ders 01 — Değişkenler ve Tipler](../Ders01_Degiskenler_ve_Tipler/ders_notu.md)
**Sonraki Ders:** [Ders 03 — Fonksiyonlar](../Ders03_Fonksiyonlar/ders_notu.md)
