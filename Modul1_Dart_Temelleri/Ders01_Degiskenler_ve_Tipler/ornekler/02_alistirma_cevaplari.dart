// Ders 01 — Alıştırma Cevapları
// Önce kendiniz deneyin, sonra buraya bakın!
// Çalıştırmak için: dart run 02_alistirma_cevaplari.dart

import 'dart:math';

void main() {
  // Alıştırma 1: Kişisel bilgiler
  print("=== Alıştırma 1: Kişisel Bilgiler ===");
  String ad = "Ali";
  String soyad = "Yılmaz";
  int yas = 20;
  double boy = 1.78;

  print("Ad: $ad");
  print("Soyad: $soyad");
  print("Tam Ad: $ad $soyad");
  print("Yaş: $yas");
  print("Boy: $boy m");

  // Alıştırma 2: İki sayı toplama
  print("\n=== Alıştırma 2: Toplama ===");
  int sayi1 = 45;
  int sayi2 = 37;
  int toplam = sayi1 + sayi2;
  print("Sonuç: $toplam");

  // Alıştırma 3: String büyük/küçük harf
  print("\n=== Alıştırma 3: Harf Dönüşümü ===");
  String egitim = "Flutter Eğitimi";
  print("Büyük: ${egitim.toUpperCase()}");
  print("Küçük: ${egitim.toLowerCase()}");

  // Alıştırma 4: String'den int'e çevirip toplama
  print("\n=== Alıştırma 4: String → int Toplama ===");
  String birinci = "25";
  String ikinci = "17";
  int sonuc = int.parse(birinci) + int.parse(ikinci);
  print("$birinci + $ikinci = $sonuc");

  // Alıştırma 5: Daire alanı
  print("\n=== Alıştırma 5: Daire Alanı ===");
  const double piSabiti = 3.14159;
  double r = 5;
  double alan = piSabiti * pow(r, 2);
  print("Yarıçap: $r");
  print("Alan: $alan");
}
