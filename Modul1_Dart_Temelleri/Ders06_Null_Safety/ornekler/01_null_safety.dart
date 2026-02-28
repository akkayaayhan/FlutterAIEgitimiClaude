// Ders 06 — Null Safety Örnekleri
// Çalıştırmak için: dart run 01_null_safety.dart

// ignore_for_file: dead_code

void main() {
  // ─── Temel null safety ────────────────────────────────────────
  print("=== Temel Null Safety ===");

  String? isim = "Ahmet";
  String? sehir = null;

  print("İsim: $isim");
  print("Şehir: $sehir");

  // ?. güvenli erişim
  print("İsim uzunluğu: ${isim?.length}"); // 5
  print("Şehir uzunluğu: ${sehir?.length}"); // null

  // ?? null coalescing
  print("Şehir: ${sehir ?? 'Belirtilmemiş'}"); // Belirtilmemiş

  // ─── Kullanıcı profili örneği ─────────────────────────────────
  print("\n=== Kullanıcı Profili ===");

  var ahmet = Kullanici(isim: "Ahmet", yas: 28);
  var zeynep = Kullanici(
    isim: "Zeynep",
    yas: 25,
    telefon: "0532-111-2233",
    email: "zeynep@email.com",
  );

  ahmet.bilgiYazdir();
  print("---");
  zeynep.bilgiYazdir();

  // ─── Null-aware zincir ────────────────────────────────────────
  print("\n=== Null-aware Zincir ===");

  List<Kullanici?> kullanicilar = [ahmet, null, zeynep, null];

  for (var k in kullanicilar) {
    String ad = k?.isim ?? "Silinmiş kullanıcı";
    String tel = k?.telefon ?? "Telefon yok";
    print("$ad — $tel");
  }

  // ─── Null filtering ───────────────────────────────────────────
  print("\n=== Null Filtreleme ===");

  List<int?> notlar = [85, null, 92, null, 67, 78, null, 95];
  print("Ham liste: $notlar");

  // whereType ile null'ları at
  List<int> gercekNotlar = notlar.whereType<int>().toList();
  print("Temiz liste: $gercekNotlar");

  double ortalama = gercekNotlar.reduce((a, b) => a + b) / gercekNotlar.length;
  print("Ortalama: ${ortalama.toStringAsFixed(2)}");

  // null yerine 0 koy
  List<int> sifirli = notlar.map((n) => n ?? 0).toList();
  print("Null→0: $sifirli");

  // ─── ??= null-aware assignment ────────────────────────────────
  print("\n=== ??= Operatörü ===");

  String? cache;
  print("Cache: $cache"); // null

  cache ??= "Veritabanından yüklendi";
  print("Cache: $cache"); // Veritabanından yüklendi

  cache ??= "Bu atanmaz"; // Artık null değil
  print("Cache: $cache"); // Veritabanından yüklendi (değişmedi)

  // ─── late keyword ─────────────────────────────────────────────
  print("\n=== late Keyword ===");

  var db = VeritabaniSimulator();
  db.baglaN("localhost", 5432);
  print("Bağlantı: ${db.baglanti}");
  db.sorguCalistir("SELECT * FROM users");

  // ─── if ile null kontrolü (smart cast) ────────────────────────
  print("\n=== Smart Cast ===");

  String? token = getToken(gecerli: true);

  if (token != null) {
    // token burada String (non-nullable) olarak muamele görür
    print("Token geçerli: ${token.substring(0, 8)}...");
    print("Token uzunluğu: ${token.length}");
  } else {
    print("Token bulunamadı");
  }

  // Erken return pattern
  String sonuc = islemYap(null);
  print(sonuc);

  String sonuc2 = islemYap("değer");
  print(sonuc2);
}

// ─── Yardımcı sınıflar ────────────────────────────────────────────

class Kullanici {
  final String isim;
  final int yas;
  final String? telefon;
  final String? email;

  Kullanici({required this.isim, required this.yas, this.telefon, this.email});

  void bilgiYazdir() {
    print("$isim ($yas yaş)");
    print("  Telefon: ${telefon ?? 'Belirtilmemiş'}");
    print("  E-posta: ${email ?? 'Belirtilmemiş'}");
  }
}

class VeritabaniSimulator {
  late String baglanti; // Sonradan atanacak

  void baglaN(String host, int port) {
    baglanti = "$host:$port/veritabani";
    print("Bağlantı kuruldu: $baglanti");
  }

  void sorguCalistir(String sql) {
    // baglanti atanmadan çağrılırsa LateInitializationError!
    print("[$baglanti] Sorgu: $sql");
  }
}

String? getToken({bool gecerli = false}) {
  return gecerli ? "tk_abc123def456ghi789" : null;
}

String islemYap(String? deger) {
  // Erken return pattern
  if (deger == null) {
    return "Değer null, işlem yapılamıyor";
  }
  // Buradan sonra deger non-nullable
  return "İşlem tamamlandı: ${deger.toUpperCase()}";
}
