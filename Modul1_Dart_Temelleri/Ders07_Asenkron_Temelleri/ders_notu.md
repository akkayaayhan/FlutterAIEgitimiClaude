# Ders 07 — Asenkron Programlama Temelleri

## Bu Derste Neler Öğreneceğiz?
- Senkron vs Asenkron nedir?
- `Future` — tek değer döndüren asenkron işlem
- `async` / `await`
- Hata yönetimi (`try/catch`)
- `Stream` — çoklu değer döndüren asenkron akış
- `then()` / `catchError()` — zincirleme

---

## 1. Senkron vs Asenkron

### Senkron (Sıralı, Bloklayan)

```
İşlem1 → tamamla → İşlem2 → tamamla → İşlem3
─────────────────────────────────────────────→ Zaman
```

```dart
// Senkron: Her satır bir sonrakini bekler
void main() {
  print("1. adım");
  // 3 saniye bekle (bu süre UI donar!)
  sleep(Duration(seconds: 3));
  print("2. adım");
  print("3. adım");
}
```

### Asenkron (Eşzamanlı, Bloklamayan)

```
İşlem1 başla → hemen devam et → İşlem1 bitti
                    ↓
               İşlem2 yap (beklerken)
─────────────────────────────────────────────→ Zaman
```

```dart
// Asenkron: Beklerken başka şeyler yapılabilir
void main() async {
  print("1. adım — API çağrısı başladı");
  String veri = await apidenGetir(); // Bekle ama bloklama!
  print("2. adım — Veri geldi: $veri");
  print("3. adım");
}
```

---

## 2. Future — Gelecekteki Bir Değer

`Future<T>`, şu an hazır olmayan ama ileride hazır olacak bir değeri temsil eder.

```
Future<String>:
┌──────────────────────────────────────┐
│  pending → (işlem devam ediyor...)   │
│  completed → "Veri geldi!"           │
│  error → Exception("Hata!")         │
└──────────────────────────────────────┘
```

```dart
// Future döndüren fonksiyon
Future<String> veriGetir() async {
  // Simüle edilmiş ağ gecikmesi
  await Future.delayed(Duration(seconds: 2));
  return "Sunucudan gelen veri";
}

// Future<void> — değer döndürmeyen async
Future<void> kaydet(String veri) async {
  await Future.delayed(Duration(milliseconds: 500));
  print("Kaydedildi: $veri");
}
```

---

## 3. async / await

`await`, bir Future'ın tamamlanmasını bekler. Yalnızca `async` işaretli fonksiyonlarda kullanılabilir.

```dart
Future<void> kullaniciBilgisiniGoster() async {
  print("Yükleniyor...");

  try {
    String kullanici = await kullaniciGetir(id: 1);
    String siparisler = await siparisleriGetir(kullanici);
    print("Kullanıcı: $kullanici");
    print("Siparişler: $siparisler");
  } catch (e) {
    print("Hata oluştu: $e");
  } finally {
    print("İşlem tamamlandı");
  }
}
```

### Birden Fazla Future'ı Bekleme

```dart
// Sırayla bekle (yavaş — her biri bir öncekini bekler):
String a = await getirA();
String b = await getirB();

// Eş zamanlı bekle (hızlı — ikisi aynı anda çalışır):
List<String> sonuclar = await Future.wait([getirA(), getirB()]);
String a = sonuclar[0];
String b = sonuclar[1];

// Dart 3.0+ — destructuring ile:
var (a, b) = await (getirA(), getirB()).wait;
```

---

## 4. Hata Yönetimi

```dart
Future<String> riskliIslem() async {
  // Hata fırlatabilir
  throw Exception("Sunucu yanıt vermedi");
}

// try/catch ile:
Future<void> main() async {
  try {
    String sonuc = await riskliIslem();
    print(sonuc);
  } on Exception catch (e) {
    print("Yakalanan hata: $e");
  } catch (e, stackTrace) {
    print("Bilinmeyen hata: $e");
    print("Stack trace: $stackTrace");
  } finally {
    print("Her durumda çalışır");
  }
}

// then().catchError() zinciri (eski yöntem):
riskliIslem()
    .then((sonuc) => print(sonuc))
    .catchError((e) => print("Hata: $e"))
    .whenComplete(() => print("Tamamlandı"));
```

---

## 5. Stream — Çoklu Asenkron Değerler

`Future` tek bir değer döndürürken, `Stream` zaman içinde birden fazla değer döndürür.

```
Future: ──────────────────[değer]
Stream: ──[1]──[2]──[3]──[4]──(tamamlandı)
```

**Ne zaman Stream kullanılır?**
- Gerçek zamanlı veriler (websocket, GPS konum)
- Dosya okuma (büyük dosyalar)
- Firebase/Firestore değişiklik dinleme
- Kullanıcı input'u (klavye, tıklama olayları)
- Timer olayları

```dart
// Stream oluşturma
Stream<int> sayac() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // Değeri stream'e ekle
  }
}

// Stream dinleme
Future<void> main() async {
  print("Sayaç başladı:");

  await for (int sayi in sayac()) {
    print("→ $sayi");
  }

  print("Sayaç bitti");
}

// listen() ile dinleme:
sayac().listen(
  (sayi) => print("Gelen: $sayi"),
  onError: (e) => print("Hata: $e"),
  onDone: () => print("Stream bitti"),
);
```

### StreamController — Manuel Stream

```dart
import 'dart:async';

void main() async {
  final controller = StreamController<String>();

  // Stream'i dinle
  controller.stream.listen(
    (mesaj) => print("Mesaj: $mesaj"),
    onDone: () => print("Stream kapatıldı"),
  );

  // Değerleri ekle
  controller.add("Birinci mesaj");
  controller.add("İkinci mesaj");
  controller.add("Üçüncü mesaj");

  // Kapat
  await controller.close();
}
```

---

## 6. FutureBuilder ve StreamBuilder (Flutter'a Hazırlık)

Flutter'da UI'ı asenkron veriyle güncellemenin temel yolu:

```dart
// FutureBuilder — bir kez veri çeker
FutureBuilder<String>(
  future: apidenGetir(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text("Hata: ${snapshot.error}");
    }
    return Text(snapshot.data ?? "Veri yok");
  },
)

// StreamBuilder — sürekli güncellenir
StreamBuilder<int>(
  stream: sayacStream(),
  builder: (context, snapshot) {
    return Text("Sayaç: ${snapshot.data ?? 0}");
  },
)
```

---

## Özet

```
Asenkron kavramlar:
├── Future<T>    → Tek bir asenkron değer (gelecekte)
├── async        → Fonksiyonu asenkron yapar
├── await        → Future'ı bekle (async içinde)
├── Stream<T>    → Çoklu asenkron değerler (zaman içinde)
├── async*       → Stream üreten fonksiyon
└── yield        → Stream'e değer ekle

Hata yönetimi:
├── try/catch    → Hataları yakala
├── on Exception → Belirli hata tipini yakala
└── finally      → Her durumda çalışır

Future paralel çalıştırma:
└── Future.wait([f1, f2, f3]) → Hepsi bitince devam et
```

---

## Alıştırmalar

1. 2 saniye bekleyip kullanıcı adı döndüren `Future<String>` fonksiyon yazın.
2. Rastgele hata fırlatan bir fonksiyon yazın ve `try/catch` ile yönetin.
3. 1'den 10'a kadar sayan, her saniyede bir değer yayan `Stream` yazın.
4. `Future.wait` ile iki farklı async işlemi eş zamanlı çalıştırın ve sonuçları yazdırın.
5. `StreamController` kullanarak bir chat simülasyonu yapın: 3 mesaj gönderip stream'i kapatın.

---

**Önceki Ders:** [Ders 06 — Null Safety](../Ders06_Null_Safety/ders_notu.md)
**Sonraki Modül:** [Modül 2 — Flutter Temelleri](../../Modul2_Flutter_Temelleri/)
