// Ders 05 — OOP Örnekleri
// Çalıştırmak için: dart run 01_oop_temelleri.dart

// ─── Sınıf tanımları ─────────────────────────────────────────────

class BankaHesabi {
  String _sahip;
  double _bakiye;
  List<String> _islemGecmisi = [];

  BankaHesabi(this._sahip, this._bakiye);

  String get sahip => _sahip;
  double get bakiye => _bakiye;
  String get durum => _bakiye >= 0 ? "Aktif" : "Borçlu";
  List<String> get gecmis => List.unmodifiable(_islemGecmisi);

  void paraYatir(double miktar) {
    if (miktar <= 0) throw ArgumentError("Miktar pozitif olmalı");
    _bakiye += miktar;
    _islemGecmisi.add("+${miktar.toStringAsFixed(2)} TL");
  }

  void paraCek(double miktar) {
    if (miktar > _bakiye) throw StateError("Yetersiz bakiye");
    _bakiye -= miktar;
    _islemGecmisi.add("-${miktar.toStringAsFixed(2)} TL");
  }

  @override
  String toString() =>
      "Hesap[${_sahip}]: ${_bakiye.toStringAsFixed(2)} TL ($durum)";
}

// ─── Kalıtım örneği ──────────────────────────────────────────────

abstract class Sekil {
  String get ad;
  double alan();
  double cevre();

  void bilgiVer() {
    print("$ad → Alan: ${alan().toStringAsFixed(2)}, "
        "Çevre: ${cevre().toStringAsFixed(2)}");
  }
}

class Daire extends Sekil {
  final double yaricap;
  Daire(this.yaricap);

  @override
  String get ad => "Daire (r=$yaricap)";

  @override
  double alan() => 3.14159 * yaricap * yaricap;

  @override
  double cevre() => 2 * 3.14159 * yaricap;
}

class Dikdortgen extends Sekil {
  final double en, boy;
  Dikdortgen(this.en, this.boy);

  @override
  String get ad => "Dikdörtgen (${en}x${boy})";

  @override
  double alan() => en * boy;

  @override
  double cevre() => 2 * (en + boy);
}

class Ucgen extends Sekil {
  final double a, b, c;
  Ucgen(this.a, this.b, this.c);

  @override
  String get ad => "Üçgen (${a}, ${b}, ${c})";

  @override
  double alan() {
    double s = (a + b + c) / 2; // Yarı çevre
    return (s * (s - a) * (s - b) * (s - c)) < 0
        ? 0
        : (s * (s - a) * (s - b) * (s - c)); // Heron formülü basitleştirildi
  }

  @override
  double cevre() => a + b + c;
}

// ─── Mixin örneği ─────────────────────────────────────────────────

mixin Loglanabilir {
  void log(String mesaj) {
    final zaman = DateTime.now().toString().substring(11, 19);
    print("[$zaman] ${runtimeType}: $mesaj");
  }
}

mixin Dogrulanabilir {
  bool dogrula() => true;
  void dogrulaVeHataVer() {
    if (!dogrula()) throw StateError("Doğrulama başarısız");
  }
}

class KullaniciServisi with Loglanabilir, Dogrulanabilir {
  String kullaniciAdi;
  KullaniciServisi(this.kullaniciAdi);

  void girisYap() {
    log("Giriş yapılıyor: $kullaniciAdi");
    dogrulaVeHataVer();
    log("Giriş başarılı: $kullaniciAdi");
  }
}

// ─── main ─────────────────────────────────────────────────────────

void main() {
  // Banka Hesabı
  print("=== Banka Hesabı ===");
  var hesap = BankaHesabi("Ahmet Yılmaz", 5000);
  print(hesap);

  hesap.paraYatir(2500);
  hesap.paraYatir(1000);
  hesap.paraCek(800);
  print(hesap);

  print("İşlem geçmişi:");
  for (var islem in hesap.gecmis) {
    print("  $islem");
  }

  // Şekiller (polimorfizm)
  print("\n=== Şekiller (Polimorfizm) ===");
  List<Sekil> sekiller = [
    Daire(5),
    Dikdortgen(4, 7),
    Dikdortgen(10, 3),
    Daire(2.5),
  ];

  for (var sekil in sekiller) {
    sekil.bilgiVer();
  }

  // En büyük alanlı şekil
  Sekil enBuyuk = sekiller.reduce(
    (a, b) => a.alan() > b.alan() ? a : b,
  );
  print("\nEn büyük alan: ${enBuyuk.ad} (${enBuyuk.alan().toStringAsFixed(2)})");

  // Toplam alan
  double toplamAlan = sekiller.map((s) => s.alan()).reduce((a, b) => a + b);
  print("Toplam alan: ${toplamAlan.toStringAsFixed(2)}");

  // Mixin
  print("\n=== Mixin (Loglanabilir) ===");
  var servis = KullaniciServisi("zeynep42");
  servis.girisYap();

  // Static kullanım
  print("\n=== Sayaç (static) ===");
  print("Oluşturulan nesne: ${Sayac.toplamSayac}");
  var s1 = Sayac();
  var s2 = Sayac();
  var s3 = Sayac();
  print("Oluşturulan nesne: ${Sayac.toplamSayac}");
  s1.ekle(5);
  s2.ekle(10);
  print("s1 değeri: ${s1.deger}, s2 değeri: ${s2.deger}");
}

class Sayac {
  static int toplamSayac = 0;
  int _deger = 0;

  Sayac() {
    toplamSayac++;
  }

  int get deger => _deger;
  void ekle(int miktar) => _deger += miktar;
}
