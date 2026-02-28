// Ders 07 — Future, async/await ve Stream Örnekleri
// Çalıştırmak için: dart run 01_future_async_await.dart

// dart:async kütüphanesi: StreamController gibi gelişmiş asenkron araçları sağlar
import 'dart:async';
// dart:math kütüphanesi: Random() sınıfını kullanmak için gerekli
import 'dart:math';

// main fonksiyonu 'async' olarak tanımlandı çünkü içinde await kullanılıyor
// 'async' olmadan await kullanmak derleme hatasına yol açar
void main() async {
  // 'await': ilgili Future tamamlanana kadar bir sonraki satıra geçmez
  // Sıralı çalışır: her fonksiyon bir önceki bitince başlar
  await ornekFuture();
  await ornekParalelFuture();
  await ornekHataYonetimi();
  await ornekStream();
  await ornekStreamController();
}

// ─── Future / async / await ───────────────────────────────────────

// Future<void>: bu fonksiyon asenkrondur ama bir değer döndürmez
// 'async' anahtar kelimesi fonksiyonu asenkron yapar ve otomatik olarak Future döner
Future<void> ornekFuture() async {
  print("=== Future / async / await ===");

  // await olmadan yazılsaydı 'kullanici' değil Future<String> dönerdi
  // await ile sanki senkronmuş gibi doğrudan String değerini alıyoruz
  print("Kullanıcı bilgisi isteniyor...");
  String kullanici = await kullaniciGetir(1);
  print("Kullanıcı: $kullanici");

  // Bir önceki await bitmeden bu satıra gelinmez (sıralı yürütme)
  print("Siparişler yükleniyor...");
  List<String> siparisler = await siparisleriGetir(1);
  // .join(', '): liste elemanlarını virgülle birleştirerek tek string yapar
  print("Siparişler: ${siparisler.join(', ')}");
}

// Birden fazla bağımsız Future'ı aynı anda (paralel) çalıştıran örnek
Future<void> ornekParalelFuture() async {
  print("\n=== Paralel Future (Future.wait) ===");

  // Süre ölçümü için başlangıç zamanı kaydediliyor
  final baslangic = DateTime.now();

  // Sıralı (yavaş): her biri diğerini bekler
  // String a = await getirA(); // 2 saniye
  // String b = await getirB(); // 2 saniye daha = 4 saniye toplam

  // Future.wait([...]): listedeki tüm Future'ları aynı anda başlatır
  // Hepsi bitince List<String> olarak sonuçları döner
  // Toplam süre = en uzun süren Future'ın süresi (3 saniye burada)
  List<String> sonuclar = await Future.wait([
    veriGetir("Kullanıcılar", 2),
    veriGetir("Ürünler", 3),
    veriGetir("Siparişler", 1),
  ]);

  // DateTime.now().difference(baslangic): iki zaman arasındaki farkı verir
  // .inSeconds: farkı saniye cinsinden tam sayı olarak döner
  final gecenSure = DateTime.now().difference(baslangic).inSeconds;
  print("3 istek paralel tamamlandı: ${gecenSure} saniyede");
  // for-in döngüsü: liste üzerinde sırayla gezer
  for (var s in sonuclar) {
    print("  → $s");
  }
}

// Asenkron işlemlerde oluşabilecek hataları yakalamayı gösteren örnek
Future<void> ornekHataYonetimi() async {
  print("\n=== Hata Yönetimi ===");

  // try/catch/finally: asenkron fonksiyonlarda da senkron kodla aynı şekilde çalışır
  // En fazla 3 kez deneme yapan döngü
  for (int deneme = 1; deneme <= 3; deneme++) {
    try {
      print("Deneme $deneme...");
      // await ile beklenen Future hata fırlatırsa catch bloğuna düşer
      String sonuc = await rastgeleHataFirlat();
      print("Başarılı: $sonuc");
      break; // Başarılıysa döngüden çık
    } on NetworkException catch (e) {
      // 'on TipAdı catch': sadece belirli hata türünü yakalar
      // Diğer hata türleri bu bloğa girmez, alttaki catch'e düşer
      print("Ağ hatası: $e — tekrar deneniyor...");
    } catch (e) {
      // Genel catch: önceki on bloğuna girmeyen tüm hataları yakalar
      print("Bilinmeyen hata: $e");
      // rethrow: yakalanan hatayı yeniden fırlatır, çağıran fonksiyona iletir
      rethrow;
    }
  }
}

// Stream: zaman içinde birden fazla değer üreten asenkron veri kaynağı
// Future tek değer dönerken Stream sürekli değer yayabilir
Future<void> ornekStream() async {
  print("\n=== Stream (async*) ===");

  // 'await for': Stream kapanana kadar her yeni değer geldiğinde döngü çalışır
  // Senkron for'un asenkron versiyonudur
  print("Sensör verileri:");
  await for (double sicaklik in sicaklikSensoru()) {
    // .toStringAsFixed(1): ondalık sayıyı 1 basamakla stringe çevirir (örn: 23.4)
    print("  Sıcaklık: ${sicaklik.toStringAsFixed(1)}°C");
  }
  print("Sensör bitti");

  // Stream metodları: Stream üzerinde filter, map gibi dönüşümler yapılabilir
  print("\nSadece yüksek sıcaklıklar (>25°C):");
  // .where((s) => s > 25): koşulu sağlamayan değerleri filtreler, yeni bir Stream döner
  await for (double s in sicaklikSensoru().where((s) => s > 25)) {
    print("  ⚠️ Yüksek: ${s.toStringAsFixed(1)}°C");
  }
}

// StreamController: manuel olarak Stream'e veri ekleyip yönetmeyi sağlar
// Gerçek zamanlı veri senaryolarında kullanılır (chat, bildirim vb.)
Future<void> ornekStreamController() async {
  print("\n=== StreamController ===");

  // StreamController<String>: String türünde veri taşıyan Stream oluşturur
  // Hem veri göndermek (sink) hem de dinlemek (stream) için arayüz sağlar
  final controller = StreamController<String>();

  // .stream.listen(...): Stream'e abone olur, her yeni veri geldiğinde callback çalışır
  // onError: Stream'den hata gelirse çalışır
  // onDone: Stream kapandığında (controller.close()) çalışır
  final abonelik = controller.stream.listen(
    (mesaj) => print("📩 $mesaj"),
    onError: (e) => print("❌ Hata: $e"),
    onDone: () => print("✅ Chat kapatıldı"),
  );

  // .add(...): Stream'e yeni bir değer gönderir, tüm dinleyicilere iletilir
  controller.add("Merhaba!");
  // Future.delayed: belirtilen süre kadar bekler (burada listen'ın işlemesi için)
  await Future.delayed(Duration(milliseconds: 100));
  controller.add("Flutter öğreniyorum");
  await Future.delayed(Duration(milliseconds: 100));
  controller.add("Çok keyifli!");
  await Future.delayed(Duration(milliseconds: 100));

  // .close(): Stream'i kapatır, onDone callback'i tetikler
  // Kapatılmayan StreamController bellek sızıntısına (memory leak) yol açar
  await controller.close();
  // .cancel(): aboneliği iptal eder, artık yeni veriler dinlenmez
  await abonelik.cancel();
}

// ─── Yardımcı fonksiyonlar ────────────────────────────────────────

// Ağdan kullanıcı verisi getirir gibi davranan sahte (mock) fonksiyon
// Future.delayed ile gerçek bir ağ gecikmesi simüle edilir
Future<String> kullaniciGetir(int id) async {
  // 800 milisaniye bekle (ağ gecikmesi simülasyonu)
  await Future.delayed(Duration(milliseconds: 800));
  // await bittikten sonra String değer döner; Future<String> otomatik sarmalanır
  return "Ahmet Yılmaz (ID: $id)";
}

// Kullanıcıya ait sipariş listesini getiren sahte asenkron fonksiyon
Future<List<String>> siparisleriGetir(int kullaniciId) async {
  await Future.delayed(Duration(milliseconds: 600));
  // List<String> döner; async fonksiyon bunu Future<List<String>> olarak sarar
  return ["Sipariş #1001 — Laptop", "Sipariş #1002 — Mouse"];
}

// Belirli bir kaynaktan veri çeken ve gecikmeyi parametreyle alan genel fonksiyon
// Future.wait örneğinde farklı sürelerle paralel çağrılmak için tasarlandı
Future<String> veriGetir(String kaynak, int saniye) async {
  // saniye parametresi kadar bekler; böylece her çağrı farklı sürede biter
  await Future.delayed(Duration(seconds: saniye));
  return "$kaynak yüklendi (${saniye}s)";
}

// %70 ihtimalle hata fırlatan, %30 ihtimalle başarılı olan fonksiyon
// Hata yönetimi örneğini test etmek için rastgelelik kullanılır
Future<String> rastgeleHataFirlat() async {
  await Future.delayed(Duration(milliseconds: 300));
  // Random().nextDouble(): 0.0 ile 1.0 arasında rastgele ondalık üretir
  // < 0.7 koşulu: %70 olasılıkla hata fırlatır
  if (Random().nextDouble() < 0.7) {
    // throw: hata nesnesini fırlatır, çağıran fonksiyondaki catch'e düşer
    throw NetworkException("Bağlantı zaman aşımı");
  }
  return "Veri başarıyla alındı";
}

// Sıcaklık sensörü simülasyonu
// 'async*': bu fonksiyon bir Stream üretir (async generator)
// 'yield': Stream'e bir sonraki değeri gönderir ve devam eder (return gibi bitirmez)
Stream<double> sicaklikSensoru() async* {
  final random = Random();
  // 6 kez değer yayar; her yield bir sonraki dinleyiciye iletilir
  for (int i = 0; i < 6; i++) {
    // Her değer arasında 300ms bekler; böylece anlık veri geliyormuş gibi davranır
    await Future.delayed(Duration(milliseconds: 300));
    // yield: Stream'e değer gönderir, fonksiyon burada durup bir sonraki talebi bekler
    yield 20 + random.nextDouble() * 10; // 20-30°C arası rastgele
  }
  // for döngüsü bitince Stream otomatik kapanır (onDone tetiklenir)
}

// Özel hata sınıfı
// 'implements Exception': Dart'ın standart Exception arayüzünü uygular
// Böylece catch bloklarında 'on NetworkException' ile özel olarak yakalanabilir
class NetworkException implements Exception {
  // final: bir kez atanır, sonradan değiştirilemez
  final String mesaj;
  // Pozisyonel constructor: nesne oluşturulurken mesaj zorunlu verilmelidir
  NetworkException(this.mesaj);

  // @override: üst sınıfın (Object) toString metodunu yeniden tanımlar
  // print(exception) veya string dönüşümünde bu metin gösterilir
  @override
  String toString() => "NetworkException: $mesaj";
}
