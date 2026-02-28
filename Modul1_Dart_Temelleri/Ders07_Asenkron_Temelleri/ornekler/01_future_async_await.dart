// Ders 07 — Future, async/await ve Stream Örnekleri
// Çalıştırmak için: dart run 01_future_async_await.dart

import 'dart:async';
import 'dart:math';

void main() async {
  await ornekFuture();
  await ornekParalelFuture();
  await ornekHataYonetimi();
  await ornekStream();
  await ornekStreamController();
}

// ─── Future / async / await ───────────────────────────────────────

Future<void> ornekFuture() async {
  print("=== Future / async / await ===");

  print("Kullanıcı bilgisi isteniyor...");
  String kullanici = await kullaniciGetir(1);
  print("Kullanıcı: $kullanici");

  print("Siparişler yükleniyor...");
  List<String> siparisler = await siparisleriGetir(1);
  print("Siparişler: ${siparisler.join(', ')}");
}

Future<void> ornekParalelFuture() async {
  print("\n=== Paralel Future (Future.wait) ===");

  final baslangic = DateTime.now();

  // Sıralı (yavaş): her biri diğerini bekler
  // String a = await getirA(); // 2 saniye
  // String b = await getirB(); // 2 saniye daha = 4 saniye toplam

  // Paralel (hızlı): ikisi aynı anda çalışır
  List<String> sonuclar = await Future.wait([
    veriGetir("Kullanıcılar", 2),
    veriGetir("Ürünler", 3),
    veriGetir("Siparişler", 1),
  ]);

  final gecenSure = DateTime.now().difference(baslangic).inSeconds;
  print("3 istek paralel tamamlandı: ${gecenSure} saniyede");
  for (var s in sonuclar) {
    print("  → $s");
  }
}

Future<void> ornekHataYonetimi() async {
  print("\n=== Hata Yönetimi ===");

  // try/catch/finally
  for (int deneme = 1; deneme <= 3; deneme++) {
    try {
      print("Deneme $deneme...");
      String sonuc = await rastgeleHataFirlat();
      print("Başarılı: $sonuc");
      break; // Başarılıysa döngüden çık
    } on NetworkException catch (e) {
      print("Ağ hatası: $e — tekrar deneniyor...");
    } catch (e) {
      print("Bilinmeyen hata: $e");
      rethrow; // Üst seviyeye ilet
    }
  }
}

Future<void> ornekStream() async {
  print("\n=== Stream (async*) ===");

  // await for ile dinle
  print("Sensör verileri:");
  await for (double sicaklik in sicaklikSensoru()) {
    print("  Sıcaklık: ${sicaklik.toStringAsFixed(1)}°C");
  }
  print("Sensör bitti");

  // Stream metodları
  print("\nSadece yüksek sıcaklıklar (>25°C):");
  await for (double s in sicaklikSensoru().where((s) => s > 25)) {
    print("  ⚠️ Yüksek: ${s.toStringAsFixed(1)}°C");
  }
}

Future<void> ornekStreamController() async {
  print("\n=== StreamController ===");

  final controller = StreamController<String>();

  // Stream'i asenkron olarak dinle
  final abonelik = controller.stream.listen(
    (mesaj) => print("📩 $mesaj"),
    onError: (e) => print("❌ Hata: $e"),
    onDone: () => print("✅ Chat kapatıldı"),
  );

  // Mesaj gönder
  controller.add("Merhaba!");
  await Future.delayed(Duration(milliseconds: 100));
  controller.add("Flutter öğreniyorum");
  await Future.delayed(Duration(milliseconds: 100));
  controller.add("Çok keyifli!");
  await Future.delayed(Duration(milliseconds: 100));

  // Kapat
  await controller.close();
  await abonelik.cancel();
}

// ─── Yardımcı fonksiyonlar ────────────────────────────────────────

Future<String> kullaniciGetir(int id) async {
  await Future.delayed(Duration(milliseconds: 800));
  return "Ahmet Yılmaz (ID: $id)";
}

Future<List<String>> siparisleriGetir(int kullaniciId) async {
  await Future.delayed(Duration(milliseconds: 600));
  return ["Sipariş #1001 — Laptop", "Sipariş #1002 — Mouse"];
}

Future<String> veriGetir(String kaynak, int saniye) async {
  await Future.delayed(Duration(seconds: saniye));
  return "$kaynak yüklendi (${saniye}s)";
}

Future<String> rastgeleHataFirlat() async {
  await Future.delayed(Duration(milliseconds: 300));
  if (Random().nextDouble() < 0.7) {
    throw NetworkException("Bağlantı zaman aşımı");
  }
  return "Veri başarıyla alındı";
}

// Sıcaklık sensörü simülasyonu
Stream<double> sicaklikSensoru() async* {
  final random = Random();
  for (int i = 0; i < 6; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    yield 20 + random.nextDouble() * 10; // 20-30°C arası rastgele
  }
}

// Özel hata sınıfı
class NetworkException implements Exception {
  final String mesaj;
  NetworkException(this.mesaj);

  @override
  String toString() => "NetworkException: $mesaj";
}
