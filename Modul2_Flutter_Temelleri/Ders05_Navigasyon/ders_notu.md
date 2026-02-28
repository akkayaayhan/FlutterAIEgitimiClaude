# Ders 05 — Navigasyon ve Routing

## Bu Derste Neler Öğreneceğiz?
- Flutter'da ekranlar arası geçiş nasıl yapılır?
- `Navigator.push` / `Navigator.pop`
- Ekranlar arası veri gönderme ve alma
- `Navigator.pushNamed` — isimli rotalar
- `Navigator.pushReplacement` ve `Navigator.pushAndRemoveUntil`
- `WillPopScope` ile geri tuşunu yakalama
- Bottom Navigation ile sayfa yönetimi (tekrar)

---

## 1. Navigator Nedir?

Flutter'da ekranlar bir **yığın (stack)** üzerinde yönetilir:

```
Yığın (Stack):
┌────────────────┐  ← push ile eklenir (üste gelir)
│  Detay Sayfası │
├────────────────┤
│  Liste Sayfası │  ← pop ile geri dönülür
├────────────────┤
│   Ana Sayfa    │  ← alt (ilk sayfa)
└────────────────┘
```

`Navigator`, bu yığını yöneten Flutter bileşenidir.

---

## 2. Temel Navigasyon: push / pop

### push — Yeni Ekran Aç

```dart
// Yeni ekrana git
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DetaySayfasi()),
);
```

### pop — Geri Dön

```dart
// Bir önceki ekrana dön
Navigator.pop(context);
```

### Tam örnek:

```dart
class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetaySayfasi(),
              ),
            );
          },
          child: const Text('Detaya Git'),
        ),
      ),
    );
  }
}

class DetaySayfasi extends StatelessWidget {
  const DetaySayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detay')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Geri Dön'),
        ),
      ),
    );
  }
}
```

> **Not:** AppBar otomatik olarak geri ok (←) düğmesi ekler. `Navigator.pop` çağrısına genellikle gerek yoktur.

---

## 3. Ekranlar Arası Veri Gönderme

### Constructor ile veri gönder (en yaygın yöntem)

```dart
class UrunDetaySayfasi extends StatelessWidget {
  final String urunAdi;
  final double fiyat;

  const UrunDetaySayfasi({
    super.key,
    required this.urunAdi,
    required this.fiyat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(urunAdi)),
      body: Center(
        child: Text(
          'Fiyat: ₺${fiyat.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Kullanım:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UrunDetaySayfasi(
      urunAdi: 'Flutter Kitabı',
      fiyat: 149.90,
    ),
  ),
);
```

---

## 4. Geri Dönerken Veri Alma

`Navigator.pop` ile veri gönderilip, `push`'un döndürdüğü `Future` ile alınabilir:

```dart
// Veriyi alan sayfa:
Future<void> _sayfayaGitVeVeriAl() async {
  final sonuc = await Navigator.push<String>(
    context,
    MaterialPageRoute(builder: (context) => const SecilenSayfasi()),
  );

  if (sonuc != null) {
    print('Seçilen: $sonuc');
  }
}

// Veriyi gönderen sayfa:
Navigator.pop(context, 'Seçilen değer');
```

---

## 5. İsimli Rotalar (Named Routes)

Büyük uygulamalarda ekran isimlerini merkezi olarak tanımlamak daha temizdir:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const AnaSayfa(),
    '/profil': (context) => const ProfilSayfasi(),
    '/ayarlar': (context) => const AyarlarSayfasi(),
    '/urun-detay': (context) => const UrunDetaySayfasi(),
  },
);

// Navigasyon:
Navigator.pushNamed(context, '/profil');

// Geri dön:
Navigator.pop(context);
```

### Arguments ile isimli rota

```dart
// Gönder:
Navigator.pushNamed(
  context,
  '/urun-detay',
  arguments: {'id': 42, 'ad': 'Flutter Kitabı'},
);

// Al (ModalRoute ile):
@override
Widget build(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map;
  return Text(args['ad']);
}
```

---

## 6. Özel Geçiş Animasyonları

```dart
// Soldan gelen animasyon
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const DetaySayfasi();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(-1, 0), end: Offset.zero),
        ),
        child: child,
      );
    },
  ),
);

// Fade (soluklaşma) animasyonu
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (_, animation, __) => const DetaySayfasi(),
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400),
  ),
);
```

---

## 7. pushReplacement — Mevcut Sayfayı Değiştir

Geri dönülmesini istemediğiniz geçişler için (örn. giriş yapıldıktan sonra):

```dart
// Giriş sayfasından ana sayfaya — geri dönülemesin
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const AnaSayfa()),
);
```

---

## 8. pushAndRemoveUntil — Tüm Yığını Temizle

```dart
// Tüm geçmişi silip ana sayfaya dön
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const AnaSayfa()),
  (route) => false, // false = hepsini kaldır
);

// Belirli bir sayfaya kadar kaldır
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const ProfilSayfasi()),
  ModalRoute.withName('/'),  // '/' rotasına kadar kaldır
);
```

---

## 9. WillPopScope — Geri Tuşunu Yönet

```dart
class FormSayfasi extends StatelessWidget {
  const FormSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // true döndür → geri git
        // false döndür → geri gitme
        final cikMi = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Çıkmak istiyor musunuz?'),
            content: const Text('Değişiklikler kaydedilmeyecek.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Çık'),
              ),
            ],
          ),
        );
        return cikMi ?? false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Form')),
        body: const Center(child: Text('Form içeriği')),
      ),
    );
  }
}
```

---

## 10. Navigator 2.0 / GoRouter (Özet)

Büyük uygulamalar için Navigator 1.0 yetersiz kalabilir. **GoRouter** paketi önerilir:

```yaml
# pubspec.yaml
dependencies:
  go_router: ^14.0.0
```

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AnaSayfa(),
    ),
    GoRoute(
      path: '/urun/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UrunDetaySayfasi(id: id);
      },
    ),
  ],
);

// Navigasyon:
context.go('/urun/42');
context.push('/urun/42');
context.pop();
```

> **Not:** GoRouter'ı Modül 7'de (İleri Flutter) detaylı işleyeceğiz.

---

## Navigasyon Özeti

```
Navigator yığın işlemleri:
├── push()               → Yeni sayfa ekle
├── pop()                → Geri dön (+ veri gönder)
├── pushNamed()          → İsimli rotayla git
├── pushReplacement()    → Mevcut sayfayı değiştir
└── pushAndRemoveUntil() → Yığını temizleyip git

Veri transferi:
├── Gönderme: Constructor parametresi (önerilen)
├── Gönderme: arguments (isimli rotalarda)
└── Geri alma: await Navigator.push() + pop(context, değer)

Yaygın kalıplar:
├── Splash → Giriş:     pushReplacement
├── Giriş → Ana Sayfa:  pushAndRemoveUntil
├── Liste → Detay:      push + pop
└── Form geri tuşu:     WillPopScope
```

---

## Alıştırmalar

1. 3 ekranlı bir uygulama yapın: Ana → Liste → Detay. Detayda ürün adını gösterin.
2. Bir giriş formu yapın. Başarılı girişte `pushReplacement` ile ana sayfaya gidin.
3. Bir detay sayfasında "Sepete Ekle" butonu koyun. Tıklanınca `pop(context, ürünAdı)` yapın. Ana sayfada bu değeri bir SnackBar ile gösterin.
4. `WillPopScope` kullanarak "Kapatmak istediğinizden emin misiniz?" diyaloğu olan bir form sayfası yapın.

---

**Önceki Ders:** [Ders 04 — StatefulWidget](../Ders04_StatefulWidget/ders_notu.md)
**Sonraki Modül:** [Modül 3 — UI Geliştirme](../../Modul3_UI_Gelistirme/)
