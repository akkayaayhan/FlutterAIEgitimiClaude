// Ders 02 — Kontrol Akışı Örnekleri
// Çalıştırmak için: dart run 01_kontrol_akisi.dart

void main() {
  // ─── if / else ────────────────────────────────────────────────
  print("=== if / else ===");
  int sicaklik = 28;

  if (sicaklik > 30) {
    print("Çok sıcak, serinleyin!");
  } else if (sicaklik > 20) {
    print("Güzel hava.");
  } else if (sicaklik > 10) {
    print("Biraz serin, hırka giyin.");
  } else {
    print("Soğuk hava, kalın giyinin!");
  }

  // ─── Ternary operatör ─────────────────────────────────────────
  print("\n=== Ternary Operatör ===");
  int puan = 72;
  String sonuc = puan >= 50 ? "Geçti" : "Kaldı";
  print("Puan: $puan → $sonuc");

  // İç içe ternary (dikkatli kullanın, okunabilirliği düşürür)
  String harfNotu = puan >= 90
      ? "AA"
      : puan >= 80
          ? "BA"
          : puan >= 70
              ? "BB"
              : "CC";
  print("Harf notu: $harfNotu");

  // ─── switch / case ────────────────────────────────────────────
  print("\n=== switch / case ===");
  int ay = 7;

  switch (ay) {
    case 1:
      print("Ocak — Kış");
      break;
    case 2:
      print("Şubat — Kış");
      break;
    case 3:
      print("Mart — İlkbahar");
      break;
    case 4:
    case 5:
      print("Nisan/Mayıs — İlkbahar");
      break;
    case 6:
    case 7:
    case 8:
      print("Yaz ayı: Ay $ay");
      break;
    case 9:
    case 10:
    case 11:
      print("Sonbahar ayı: Ay $ay");
      break;
    case 12:
      print("Aralık — Kış");
      break;
    default:
      print("Geçersiz ay");
  }

  // ─── for döngüsü ──────────────────────────────────────────────
  print("\n=== for Döngüsü ===");
  int toplam = 0;
  for (int i = 1; i <= 10; i++) {
    toplam += i;
  }
  print("1'den 10'a kadar toplam: $toplam");

  // 5 kere tablo
  int carpan = 7;
  print("\n$carpan çarpım tablosu:");
  for (int i = 1; i <= 10; i++) {
    print("$carpan x $i = ${carpan * i}");
  }

  // ─── for-in döngüsü ───────────────────────────────────────────
  print("\n=== for-in Döngüsü ===");
  List<String> sehirler = ["İstanbul", "Ankara", "İzmir", "Bursa", "Antalya"];
  for (String sehir in sehirler) {
    print("- $sehir");
  }

  // ─── while döngüsü ────────────────────────────────────────────
  print("\n=== while Döngüsü ===");
  // 2'nin kuvvetleri (100'den küçük olanlar)
  int kuvvet = 1;
  while (kuvvet < 100) {
    print("2^? = $kuvvet");
    kuvvet *= 2;
  }

  // ─── break ve continue ────────────────────────────────────────
  print("\n=== break ve continue ===");
  print("continue (çiftleri atla):");
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) continue;
    print(i);
  }

  print("\nbreak (4'te dur):");
  for (int i = 1; i <= 10; i++) {
    if (i > 4) break;
    print(i);
  }

  // ─── FizzBuzz (klasik programlama sorusu) ─────────────────────
  print("\n=== FizzBuzz (1-20) ===");
  for (int i = 1; i <= 20; i++) {
    if (i % 15 == 0) {
      print("FizzBuzz");
    } else if (i % 3 == 0) {
      print("Fizz");
    } else if (i % 5 == 0) {
      print("Buzz");
    } else {
      print(i);
    }
  }
}
