# Modül 2 — Flutter Temelleri

> Dart temellerini öğrendikten sonra Flutter ile gerçek uygulamalar geliştirmeye başlıyoruz. Bu modül Flutter'ın temel yapı taşlarını kapsar.

## Dersler

| # | Ders | Konu | Örnek Uygulama |
|---|------|------|----------------|
| 01 | [Flutter Kurulumu ve Proje Yapısı](./Ders01_Kurulum_ve_Proje_Yapisi/ders_notu.md) | Flutter SDK, flutter doctor, proje yapısı, pubspec.yaml | — (kod örneği yok) |
| 02 | [Widget Kavramı](./Ders02_Widget_Kavrami/ders_notu.md) | StatelessWidget, Text, Icon, Image, Button, Container | [ornekler/](./Ders02_Widget_Kavrami/ornekler/) |
| 03 | [Layout Widget'ları](./Ders03_Layout_Widgetlari/ders_notu.md) | Column, Row, Expanded, Stack, ListView, GridView | [ornekler/](./Ders03_Layout_Widgetlari/ornekler/) |
| 04 | [StatefulWidget](./Ders04_StatefulWidget/ders_notu.md) | setState, lifecycle, Timer, Form, TextEditingController | [ornekler/](./Ders04_StatefulWidget/ornekler/) |
| 05 | [Navigasyon](./Ders05_Navigasyon/ders_notu.md) | push/pop, veri aktarma, isimli rotalar, WillPopScope | [ornekler/](./Ders05_Navigasyon/ornekler/) |

## Örnek Uygulamaları Çalıştırma

Her ders klasöründe çalışan bir Flutter uygulaması bulunmaktadır:

```bash
# Örnek: Ders 04 uygulamasını çalıştır
cd Ders04_StatefulWidget/ornekler
flutter pub get     # İlk kez çalıştırmadan önce
flutter run         # Bağlı cihazda veya emülatörde başlat

# Web tarayıcısında çalıştır
flutter run -d chrome

# Windows'ta çalıştır
flutter run -d windows
```

> **Gereksinim:** Flutter SDK kurulu ve bir cihaz/emülatör bağlı olmalıdır.

## Modül Özeti

```
Flutter temel kavramları:
│
├── Widget               → Her şey bir widget'tır
│   ├── StatelessWidget  → Değişmeyen UI bileşenleri
│   └── StatefulWidget   → Zaman içinde değişen bileşenler
│
├── Layout               → Widget'ları düzenle
│   ├── Column / Row     → Dikey / yatay yerleşim
│   ├── Stack            → Üst üste bindirme
│   └── ListView         → Kaydırılabilir liste
│
├── State Yönetimi       → UI'ı güncelle
│   ├── setState()       → En temel yöntem
│   └── dispose()        → Kaynakları temizle
│
└── Navigasyon           → Ekranlar arası geçiş
    ├── Navigator.push   → Yeni ekrana git
    ├── Navigator.pop    → Geri dön
    └── isimli rotalar   → Merkezi rota yönetimi
```

## Tamamlanma Kontrol Listesi

Her dersi tamamladıktan sonra işaretleyin:

- [ ] Ders 01 — Flutter Kurulumu ve Proje Yapısı
- [ ] Ders 02 — Widget Kavramı (StatelessWidget)
- [ ] Ders 03 — Layout Widget'ları
- [ ] Ders 04 — StatefulWidget ve setState
- [ ] Ders 05 — Navigasyon ve Routing

---

**Önceki Modül:** [Modül 1 — Dart Temelleri](../Modul1_Dart_Temelleri/)
**Sonraki Modül:** [Modül 3 — UI Geliştirme](../Modul3_UI_Gelistirme/)
