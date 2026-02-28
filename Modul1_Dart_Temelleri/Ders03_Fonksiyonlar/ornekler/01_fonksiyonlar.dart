// Ders 03 — Fonksiyonlar Örnekleri
// Çalıştırmak için: dart run 01_fonksiyonlar.dart

void main() {
  // ─── Temel fonksiyonlar ───────────────────────────────────────
  print("=== Temel Fonksiyonlar ===");
  print(topla(3, 5));          // 8
  print(carp(4, 7));           // 28
  print(daireCevresi(5));      // ~31.41
  selamVer("Dünya");           // Merhaba, Dünya!

  // ─── İsimli parametreler ──────────────────────────────────────
  print("\n=== İsimli Parametreler ===");
  kullaniciOlustur(isim: "Ayşe", yas: 28, sehir: "İzmir");
  kullaniciOlustur(isim: "Mehmet", yas: 35);

  // ─── İsteğe bağlı parametreler ────────────────────────────────
  print("\n=== İsteğe Bağlı Parametreler ===");
  print(tamAd("Ali", "Yılmaz"));
  print(tamAd("Fatma", "Kaya", unvan: "Dr."));

  // ─── Lambda ve map/where/reduce ───────────────────────────────
  print("\n=== Lambda ve Koleksiyon Fonksiyonları ===");
  List<int> sayilar = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  List<int> kareler = sayilar.map((x) => x * x).toList();
  print("Kareler: $kareler");

  List<int> ciftler = sayilar.where((x) => x % 2 == 0).toList();
  print("Çiftler: $ciftler");

  int toplam = sayilar.reduce((a, b) => a + b);
  print("Toplam: $toplam");

  double ortalama = toplam / sayilar.length;
  print("Ortalama: $ortalama");

  bool hepsiBuyukSifir = sayilar.every((x) => x > 0);
  print("Hepsi > 0: $hepsiBuyukSifir");

  bool bazilariOndan_buyuk = sayilar.any((x) => x > 8);
  print("Bazıları > 8: $bazilariOndan_buyuk");

  // ─── Higher-order function ────────────────────────────────────
  print("\n=== Higher-Order Functions ===");
  var ikiKati = carpanUret(2);
  var ucKati = carpanUret(3);

  print("5'in iki katı: ${ikiKati(5)}");
  print("5'in üç katı: ${ucKati(5)}");

  // ─── Rekürsif fonksiyonlar ────────────────────────────────────
  print("\n=== Rekürsif Fonksiyonlar ===");
  for (int i = 1; i <= 7; i++) {
    print("$i! = ${faktoryel(i)}");
  }

  print("\nFibonacci dizisi:");
  for (int i = 0; i <= 8; i++) {
    print("F($i) = ${fibonacci(i)}");
  }

  // ─── Record (Dart 3.0+) ───────────────────────────────────────
  print("\n=== Records ===");
  var istatistik = istatistikHesapla([3, 7, 1, 9, 4, 6, 2, 8, 5]);
  print("Min: ${istatistik.$1}");
  print("Max: ${istatistik.$2}");
  print("Ortalama: ${istatistik.$3.toStringAsFixed(2)}");
}

// ─── Fonksiyon tanımları ──────────────────────────────────────────

int topla(int a, int b) => a + b;

int carp(int a, int b) => a * b;

double daireCevresi(double r) => 2 * 3.14159 * r;

void selamVer(String isim) => print("Merhaba, $isim!");

void kullaniciOlustur({
  required String isim,
  required int yas,
  String sehir = "Bilinmiyor",
}) {
  print("Kullanıcı: $isim, $yas yaşında, $sehir'den");
}

String tamAd(String ad, String soyad, {String? unvan}) {
  return unvan != null ? "$unvan $ad $soyad" : "$ad $soyad";
}

Function carpanUret(int carpan) => (int sayi) => sayi * carpan;

int faktoryel(int n) {
  if (n <= 1) return 1;
  return n * faktoryel(n - 1);
}

int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

(int, int, double) istatistikHesapla(List<int> sayilar) {
  List<int> sirali = List.from(sayilar)..sort();
  int toplam = sayilar.reduce((a, b) => a + b);
  return (sirali.first, sirali.last, toplam / sayilar.length);
}
