// Ders 01 — Örnek 1: Temel Değişkenler
// Bu dosyayı çalıştırmak için: dart run 01_temel_degiskenler.dart

void main() {
  // ─── Temel veri tipleri ───────────────────────────────────────
  int yas = 25;
  double boy = 1.75;
  String isim = "Ahmet";
  bool ogrenciMi = true;

  print("=== Temel Değişkenler ===");
  print("İsim: $isim");
  print("Yaş: $yas");
  print("Boy: $boy metre");
  print("Öğrenci mi: $ogrenciMi");

  // ─── var ile tip çıkarımı ─────────────────────────────────────
  print("\n=== var ile Tip Çıkarımı ===");
  var sehir = "İstanbul";    // String olarak çıkarıldı
  var nufus = 15000000;      // int olarak çıkarıldı
  var sicaklik = 23.5;       // double olarak çıkarıldı

  print("Şehir: $sehir (tip: ${sehir.runtimeType})");
  print("Nüfus: $nufus (tip: ${nufus.runtimeType})");
  print("Sıcaklık: $sicaklik (tip: ${sicaklik.runtimeType})");

  // ─── final ve const ───────────────────────────────────────────
  print("\n=== final ve const ===");
  const double pi = 3.14159;
  const int maksimumDeneme = 3;
  final String oturumId = DateTime.now().millisecondsSinceEpoch.toString();

  print("Pi sayısı: $pi");
  print("Maksimum deneme: $maksimumDeneme");
  print("Oturum ID: $oturumId");

  // ─── String işlemleri ─────────────────────────────────────────
  print("\n=== String İşlemleri ===");
  String mesaj = "Flutter ile mobil uygulama geliştiriyorum";

  print("Orijinal: $mesaj");
  print("Uzunluk: ${mesaj.length}");
  print("Büyük harf: ${mesaj.toUpperCase()}");
  print("Flutter içeriyor mu: ${mesaj.contains('Flutter')}");
  print("Flutter → Dart: ${mesaj.replaceAll('Flutter', 'Dart')}");

  // ─── String interpolasyon ─────────────────────────────────────
  print("\n=== String İnterpolasyon ===");
  String ad = "Zeynep";
  int sinif = 3;
  double not_ = 87.5;

  print("$ad, $sinif. sınıf öğrencisi");
  print("Not ortalaması: $not_");
  print("Harf notu: ${not_ >= 90 ? 'AA' : not_ >= 80 ? 'BA' : 'BB'}");

  // ─── Sayısal işlemler ─────────────────────────────────────────
  print("\n=== Sayısal İşlemler ===");
  int x = 17;
  int y = 5;

  print("$x + $y = ${x + y}");
  print("$x - $y = ${x - y}");
  print("$x * $y = ${x * y}");
  print("$x / $y = ${x / y}");    // double: 3.4
  print("$x ~/ $y = ${x ~/ y}");  // int bölme: 3
  print("$x % $y = ${x % y}");    // mod: 2

  // ─── Tip dönüşümleri ──────────────────────────────────────────
  print("\n=== Tip Dönüşümleri ===");
  String sayiMetni = "42";
  int donusturulmus = int.parse(sayiMetni);
  print("'$sayiMetni' → int: ${donusturulmus + 1}");

  double ondalik = 9.7;
  int kesilmis = ondalik.toInt();
  print("$ondalik → int: $kesilmis (yuvarlama yok, kesilir)");

  int tamSayi = 100;
  print("$tamSayi → String: '${tamSayi.toString()}'");
}
