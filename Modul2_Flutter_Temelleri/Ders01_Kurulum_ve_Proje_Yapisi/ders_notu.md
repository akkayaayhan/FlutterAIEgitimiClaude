# Ders 01 — Flutter Kurulumu ve Proje Yapısı

## Bu Derste Neler Öğreneceğiz?
- Flutter nedir, neden kullanılır?
- Flutter SDK kurulumu
- İlk Flutter projesi oluşturma
- Proje klasör yapısı
- `main.dart` dosyasını anlamak
- Hot Reload ve Hot Restart

---

## 1. Flutter Nedir?

Flutter, Google tarafından geliştirilen **açık kaynak bir UI framework**'tür.

```
Tek kod tabanı → Birden fazla platform
┌─────────────────────────────────────────────┐
│              Flutter Uygulaması             │
│                (Dart kodu)                  │
└──────┬──────┬──────┬──────┬────────┬────────┘
       ↓      ↓      ↓      ↓        ↓        ↓
   Android   iOS  macOS Windows   Linux    Web
```

**Neden Flutter?**
- Tek kod → 6 platform (Android, iOS, Web, Windows, macOS, Linux)
- Dart dili (zaten öğrendik!)
- Çok hızlı geliştirme (Hot Reload ile anında önizleme)
- Zengin widget kütüphanesi
- Büyük topluluk ve Google desteği

---

## 2. Flutter Kurulumu

### Adım 1: Flutter SDK İndir

Flutter'ın resmi sitesinden işletim sisteminize uygun sürümü indirin:
**https://flutter.dev/docs/get-started/install**

#### Windows:
1. `flutter_windows_x.x.x-stable.zip` indir
2. `C:\flutter` gibi bir klasöre çıkart
3. `C:\flutter\bin` klasörünü PATH'e ekle

#### macOS:
```bash
# Homebrew ile:
brew install --cask flutter
# veya manuel indirip PATH ekleyin
```

### Adım 2: Flutter Doctor Çalıştır

```bash
flutter doctor
```

Çıktı şuna benzer:
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain
[✓] Xcode (macOS için)
[✓] Chrome
[✓] VS Code (version x.x.x)
[✓] Connected device (2 available)
```

Tüm satırlar `[✓]` olana kadar eksikleri tamamlayın.

### Adım 3: IDE Kurulumu

**VS Code (Önerilen):**
1. VS Code'u kur: https://code.visualstudio.com
2. Extensions → "Flutter" eklentisini kur (Dart da otomatik yüklenir)

**Android Studio:**
1. Android Studio'yu kur
2. Plugins → "Flutter" ve "Dart" eklentilerini kur

---

## 3. İlk Flutter Projesi Oluşturma

```bash
# Terminal / Komut istemi açın
flutter create merhaba_dunya

# Projeye girin
cd merhaba_dunya

# Çalıştır
flutter run
```

> **Emülatör / Cihaz:** `flutter run` çalıştırmadan önce bir Android emülatörü veya gerçek cihaz bağlı olmalı.

---

## 4. Proje Klasör Yapısı

```
merhaba_dunya/
├── android/          → Android'e özgü ayarlar
├── ios/              → iOS'a özgü ayarlar
├── lib/              → ★ BURASI BİZİM ÇALIŞMA ALANIMIMIZ
│   └── main.dart     → Uygulamanın giriş noktası
├── test/             → Test dosyaları
├── web/              → Web platformu ayarları
├── pubspec.yaml      → Proje bağımlılıkları (paket listesi)
└── pubspec.lock      → Sabit paket versiyonları
```

> **Önemli:** Kodlarımızın neredeyse tamamı `lib/` klasörüne yazılır.

---

## 5. pubspec.yaml — Proje Ayarları

```yaml
name: merhaba_dunya          # Proje adı
description: İlk Flutter uygulamam

version: 1.0.0+1             # Sürüm numarası

environment:
  sdk: '>=3.0.0 <4.0.0'      # Dart SDK versiyonu

dependencies:
  flutter:
    sdk: flutter
  # Buraya paket eklersiniz:
  # http: ^1.1.0
  # provider: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true  # Material ikonları kullan

  # Görseller/fontlar buraya eklenir:
  # assets:
  #   - assets/images/
  # fonts:
  #   - family: Roboto
```

---

## 6. main.dart'ı Anlamak

Yeni bir proje açtığınızda `lib/main.dart` şöyle görünür:

```dart
import 'package:flutter/material.dart';

// Uygulamanın başladığı yer
void main() {
  runApp(const MyApp());
}

// Kök widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Ana ekran widget'ı
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Butona bastığın sayı:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Artır',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Katman Katman Açıklama

```
void main()
    └── runApp()             → Flutter'ı başlatır
            └── MaterialApp  → Uygulamanın kök widget'ı
                    └── Scaffold     → Ekran iskeleti
                            ├── AppBar       → Üst çubuk
                            ├── body         → İçerik
                            └── FAB          → Yüzen buton
```

---

## 7. Hot Reload vs Hot Restart

| | Hot Reload | Hot Restart |
|--|-----------|-------------|
| Kısayol | `r` (terminal) veya `Ctrl+\` (VS Code) | `R` veya `Ctrl+Shift+\` |
| Ne yapar? | Değişiklikleri anında uygular | Uygulamayı sıfırdan başlatır |
| State korunur mu? | ✅ Evet | ❌ Hayır |
| Ne zaman kullanılır? | UI değişikliklerinde | State hatalarında |

---

## 8. Temel Flutter Komutları

```bash
# Yeni proje oluştur
flutter create proje_adi

# Çalıştır (bağlı cihazda)
flutter run

# Web'de çalıştır
flutter run -d chrome

# Build al (release)
flutter build apk           # Android
flutter build ios           # iOS
flutter build web           # Web

# Paket ekle (pubspec.yaml'a da ekler)
flutter pub add paket_adi

# Paketleri güncelle
flutter pub get

# Kod analizi
flutter analyze

# Testleri çalıştır
flutter test
```

---

## 9. Temiz bir main.dart Başlangıcı

Kendi projelerimizde kullanacağımız minimal başlangıç şablonu:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const UygulamaNokta());
}

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benim Uygulamam',
      debugShowCheckedModeBanner: false,  // Debug etiketini kaldır
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: const Center(
        child: Text('Merhaba Flutter!'),
      ),
    );
  }
}
```

---

## Özet

```
Flutter proje akışı:
1. flutter create proje_adi   → Proje oluştur
2. lib/main.dart düzenle      → Kod yaz
3. flutter run                → Çalıştır
4. Kaydet                     → Hot Reload ile anında gör

Önemli dosyalar:
├── lib/main.dart   → Giriş noktası (buradan başla)
├── pubspec.yaml    → Bağımlılıklar ve ayarlar
└── lib/            → Tüm Dart kodları buraya
```

---

**Sonraki Ders:** [Ders 02 — Widget Kavramı](../Ders02_Widget_Kavrami/ders_notu.md)
