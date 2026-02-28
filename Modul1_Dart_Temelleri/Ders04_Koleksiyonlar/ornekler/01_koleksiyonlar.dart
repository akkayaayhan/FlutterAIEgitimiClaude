// Ders 04 — Koleksiyonlar Örnekleri
// Çalıştırmak için: dart run 01_koleksiyonlar.dart

void main() {
  // ─── LIST ──────────────────────────────────────────────────────
  print("=== LIST ===");

  List<String> ogrenciler = ["Ahmet", "Zeynep", "Murat", "Fatma", "Ali"];
  print("Öğrenciler: $ogrenciler");
  print("İlk: ${ogrenciler.first}, Son: ${ogrenciler.last}");
  print("Sayı: ${ogrenciler.length}");

  // Ekleme
  ogrenciler.add("Elif");
  ogrenciler.insert(2, "Burak"); // 2. indekse ekle
  print("Ekleme sonrası: $ogrenciler");

  // Sıralama
  ogrenciler.sort();
  print("Alfabetik: $ogrenciler");

  // Filtreleme (a harfi içerenler)
  List<String> aHarfli = ogrenciler
      .where((isim) => isim.toLowerCase().contains("a"))
      .toList();
  print("'a' içerenler: $aHarfli");

  // ─── Sayı listesiyle işlemler ──────────────────────────────────
  print("\n=== Sayı Listesi İşlemleri ===");
  List<int> notlar = [78, 92, 65, 88, 73, 95, 61, 84];

  print("Notlar: $notlar");
  print("En yüksek: ${notlar.reduce((a, b) => a > b ? a : b)}");
  print("En düşük: ${notlar.reduce((a, b) => a < b ? a : b)}");

  double ortalama = notlar.reduce((a, b) => a + b) / notlar.length;
  print("Ortalama: ${ortalama.toStringAsFixed(2)}");

  List<int> basarilar = notlar.where((not) => not >= 70).toList();
  print("Başarılı notlar (>=70): $basarilar");

  List<String> harfNotlari = notlar.map((not) {
    if (not >= 90) return "AA";
    if (not >= 80) return "BA";
    if (not >= 70) return "BB";
    return "FF";
  }).toList();
  print("Harf notları: $harfNotlari");

  // ─── MAP ───────────────────────────────────────────────────────
  print("\n=== MAP ===");

  Map<String, int> ogrenciNotlari = {
    "Ahmet": 85,
    "Zeynep": 92,
    "Murat": 67,
    "Fatma": 78,
    "Ali": 55,
  };

  print("Tüm notlar:");
  ogrenciNotlari.forEach((isim, not) {
    String durum = not >= 70 ? "✓ Geçti" : "✗ Kaldı";
    print("  $isim: $not ($durum)");
  });

  // Geçen öğrenciler
  Map<String, int> gecenler = Map.fromEntries(
    ogrenciNotlari.entries.where((e) => e.value >= 70),
  );
  print("\nGeçen öğrenciler: $gecenler");

  // Sınıf ortalaması
  double sinifOrtalamasi =
      ogrenciNotlari.values.reduce((a, b) => a + b) /
      ogrenciNotlari.length;
  print("Sınıf ortalaması: ${sinifOrtalamasi.toStringAsFixed(1)}");

  // ─── Ürün kataloğu (Map<String, Map>) ─────────────────────────
  print("\n=== Ürün Kataloğu ===");
  Map<String, Map<String, dynamic>> urunler = {
    "laptop": {"fiyat": 15000, "stok": 10, "marka": "Dell"},
    "telefon": {"fiyat": 8000, "stok": 25, "marka": "Samsung"},
    "tablet": {"fiyat": 5000, "stok": 15, "marka": "Apple"},
  };

  urunler.forEach((urunAdi, bilgiler) {
    print("$urunAdi: ${bilgiler['marka']} - ${bilgiler['fiyat']} TL "
        "(Stok: ${bilgiler['stok']})");
  });

  // 8000 TL üzeri ürünler
  print("\n8000 TL üzeri ürünler:");
  urunler.forEach((ad, bilgi) {
    if (bilgi["fiyat"] > 8000) print("  - $ad");
  });

  // ─── SET ───────────────────────────────────────────────────────
  print("\n=== SET ===");

  Set<String> programlamaDilleri = {"Dart", "Python", "JavaScript", "Java"};
  Set<String> mobileGelistirme = {"Dart", "Swift", "Kotlin", "Java"};

  print("Programlama: $programlamaDilleri");
  print("Mobil: $mobileGelistirme");
  print("Ortak (Kesişim): ${programlamaDilleri.intersection(mobileGelistirme)}");
  print("Hepsi (Birleşim): ${programlamaDilleri.union(mobileGelistirme)}");
  print("Sadece programlama: ${programlamaDilleri.difference(mobileGelistirme)}");

  // Tekrarlı listeden benzersizler
  List<int> tekrarli = [1, 2, 2, 3, 3, 3, 4, 4, 5];
  Set<int> benzersiz = tekrarli.toSet();
  print("\nTekrarlı: $tekrarli");
  print("Benzersiz: $benzersiz");

  // ─── Collection if/for ─────────────────────────────────────────
  print("\n=== Collection if ve for ===");

  bool vipMi = true;
  List<String> menuler = [
    "Ana Sayfa",
    "Profil",
    "Ayarlar",
    if (vipMi) "VIP İçerik",
    if (vipMi) "Özel Teklifler",
  ];
  print("Menüler: $menuler");

  // Spread operatörü
  List<int> a = [1, 2, 3];
  List<int> b = [7, 8, 9];
  List<int> birlesik = [...a, 4, 5, 6, ...b];
  print("Birleşik liste: $birlesik");
}
