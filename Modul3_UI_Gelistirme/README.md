# Modül 3 — UI Geliştirme & Tasarım

Bu modülde Flutter'ın zengin UI bileşenlerini, tema sistemini ve responsive tasarım prensiplerini öğreniyoruz.

---

## Dersler

| Ders | Konu | Temel Widget'lar |
|------|------|------------------|
| [Ders 01](./Ders01_Material_Tasarim/ders_notu.md) | Material Design Bileşenleri | `AppBar`, `Drawer`, `Card`, `Chip`, `SnackBar`, `Dialog`, `BottomSheet` |
| [Ders 02](./Ders02_Formlar_ve_Input/ders_notu.md) | Formlar ve Input | `TextField`, `TextFormField`, `Form`, `Checkbox`, `Switch`, `Radio`, `Slider`, `Dropdown` |
| [Ders 03](./Ders03_Liste_Gorunumleri/ders_notu.md) | Liste Görünümleri | `ListView.builder`, `GridView.builder`, `CustomScrollView`, `ReorderableListView` |
| [Ders 04](./Ders04_Tema_ve_Stil/ders_notu.md) | Tema ve Stil | `ThemeData`, `ColorScheme`, `TextTheme`, `TextStyle`, dark/light mode |
| [Ders 05](./Ders05_Responsive_Tasarim/ders_notu.md) | Responsive Tasarım | `MediaQuery`, `LayoutBuilder`, `Expanded`, `Wrap`, `FittedBox`, `AspectRatio` |

---

## Örnekleri Çalıştırma

Her ders kendi bağımsız Flutter projesine sahiptir:

```bash
# Örnek: Ders 01
cd Ders01_Material_Tasarim/ornekler
flutter pub get
flutter run

# Tarayıcıda (pencere boyutunu değiştirerek responsive test edebilirsiniz)
flutter run -d chrome

# Windows masaüstü
flutter run -d windows
```

---

## Modül Haritası

```
Modül 3 — UI Geliştirme
│
├── Ders01: Material Design
│   ├── AppBar / Drawer (navigasyon)
│   ├── ElevatedButton / FAB (aksiyonlar)
│   ├── Card / ListTile (içerik)
│   ├── Chip (etiket)
│   └── SnackBar / Dialog / BottomSheet (geri bildirim)
│
├── Ders02: Formlar
│   ├── TextFormField + validator (doğrulama)
│   ├── TextEditingController (metin yönetimi)
│   ├── Checkbox / Switch / Radio (seçimler)
│   ├── Slider (aralık)
│   └── DropdownButtonFormField (açılır liste)
│
├── Ders03: Listeler
│   ├── ListView.builder (dikey liste)
│   ├── ListView.separated (ayraçlı)
│   ├── GridView.builder (ızgara)
│   ├── CustomScrollView + Slivers
│   ├── Dismissible (kaydırarak sil)
│   └── ReorderableListView (sürükle-bırak)
│
├── Ders04: Tema
│   ├── ThemeData + ColorScheme.fromSeed
│   ├── Light / Dark mode
│   ├── TextTheme (tipografi hiyerarşisi)
│   └── Runtime tema değiştirme
│
└── Ders05: Responsive
    ├── MediaQuery (ekran boyutu)
    ├── LayoutBuilder (ebeveyn boyutu)
    ├── Kırılım noktaları (mobil/tablet/masaüstü)
    ├── Expanded / Flexible / Wrap
    ├── FittedBox / AspectRatio
    └── OrientationBuilder
```

---

## Tamamlama Kontrol Listesi

- [ ] Ders 01: `showModalBottomSheet` ve `AlertDialog` kullanabiliyorum
- [ ] Ders 02: `GlobalKey<FormState>` ile form doğrulama yapabiliyorum
- [ ] Ders 03: `ListView.builder` ile büyük liste oluşturabiliyorum
- [ ] Ders 04: Özel tema tanımlayıp light/dark modu değiştirebiliyorum
- [ ] Ders 05: Ekran boyutuna göre farklı layout gösterebiliyorum

---

**Önceki Modül:** [Modül 2 — Flutter Temelleri](../Modul2_Flutter_Temelleri/)
**Sonraki Modül:** [Modül 4 — State Management](../Modul4_State_Management/)
