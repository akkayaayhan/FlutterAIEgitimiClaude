# Ders 04 — StatefulWidget

## Bu Derste Neler Öğreneceğiz?
- Stateless vs Stateful farkı
- `StatefulWidget` yapısı
- `setState()` ile UI güncelleme
- Widget yaşam döngüsü (lifecycle)
- Pratik: Sayaç, toggle, form

---

## 1. State (Durum) Nedir?

**State**, bir widget'ın zaman içinde değişebilen verisine denir.

```
StatelessWidget:         StatefulWidget:
┌────────────────┐       ┌────────────────┐
│  Sabit içerik  │       │  Değişen içerik│
│  (rebuild yok) │       │  (setState ile │
│                │       │   rebuild olur)│
└────────────────┘       └────────────────┘

Örnekler:
Stateless → Logo, başlık metni, hakkında sayfası
Stateful  → Sayaç, sekmeler, formlar, animasyonlar
```

---

## 2. StatefulWidget Yapısı

`StatefulWidget` **iki** sınıftan oluşur:

```dart
// 1. Widget sınıfı (değişmez, parametreleri tutar)
class SayacWidget extends StatefulWidget {
  final String baslik; // Widget parametresi

  const SayacWidget({super.key, required this.baslik});

  @override
  State<SayacWidget> createState() => _SayacWidgetState();
}

// 2. State sınıfı (değişen veriler ve build metodu burada)
class _SayacWidgetState extends State<SayacWidget> {
  int _sayac = 0; // State değişkeni

  void _artir() {
    setState(() {   // setState → Flutter'a "yeniden çiz!" der
      _sayac++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.baslik), // widget. ile parent'tan gelen değere eriş
        Text('$_sayac'),
        ElevatedButton(onPressed: _artir, child: const Text('+')),
      ],
    );
  }
}
```

**Kural:** State değişkenleri `_` ile başlar (private convention).

---

## 3. setState() — Neden Gerekli?

```dart
// YANLIŞ — UI güncellenmez!
void _artirYanlis() {
  _sayac++; // Değer değişir ama Flutter haberdar olmaz
}

// DOĞRU — UI güncellenir
void _artirDogru() {
  setState(() {
    _sayac++; // setState içinde değiştir → Flutter yeniden çizer
  });
}
```

`setState()` çağrıldığında:
1. State değişkeni güncellenir
2. `build()` metodu tekrar çağrılır
3. Widget ağacı fark hesaplanır (diff)
4. Sadece değişen kısımlar güncellenir

---

## 4. Widget Yaşam Döngüsü (Lifecycle)

```
createState()
    ↓
initState()        ← Widget oluşturulduğunda (bir kez)
    ↓
build()            ← Her setState'de tekrarlanır
    ↓
didUpdateWidget()  ← Parent widget güncellenmişse
    ↓
dispose()          ← Widget kaldırıldığında (temizlik)
```

```dart
class _OrnekState extends State<OrnekWidget> {
  late Timer _timer;
  int _saniye = 0;

  @override
  void initState() {
    super.initState(); // Mutlaka çağrılmalı
    // Timer başlat, API çağrısı yap, stream abone ol...
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => _saniye++);
    });
  }

  @override
  void didUpdateWidget(OrnekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Parent'tan gelen parametreler değiştiğinde
    if (oldWidget.baslik != widget.baslik) {
      print('Başlık değişti');
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Temizlik! Memory leak'i önler
    super.dispose(); // Mutlaka çağrılmalı
  }

  @override
  Widget build(BuildContext context) {
    return Text('Geçen süre: $_saniye saniye');
  }
}
```

**Önemli:** `initState`'te başlatılan kaynakları (timer, controller, stream) `dispose`'da mutlaka temizleyin!

---

## 5. TextEditingController — Form Girişi

```dart
class _FormState extends State<FormWidget> {
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _sonuc = '';

  @override
  void dispose() {
    _adController.dispose();   // Mutlaka temizle!
    _emailController.dispose();
    super.dispose();
  }

  void _gonder() {
    setState(() {
      _sonuc = 'Gönderildi: ${_adController.text} — ${_emailController.text}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _adController,
          decoration: const InputDecoration(
            labelText: 'Ad Soyad',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'E-posta',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _gonder, child: const Text('Gönder')),
        if (_sonuc.isNotEmpty) Text(_sonuc),
      ],
    );
  }
}
```

---

## 6. Yaygın State Kullanımları

### Toggle (Açma/Kapama)

```dart
bool _karanlikMod = false;

Switch(
  value: _karanlikMod,
  onChanged: (deger) {
    setState(() => _karanlikMod = deger);
  },
)
```

### Liste'ye Eleman Ekleme/Çıkarma

```dart
List<String> _gorevler = [];

void _gorevEkle(String gorev) {
  setState(() => _gorevler.add(gorev));
}

void _gorevSil(int index) {
  setState(() => _gorevler.removeAt(index));
}
```

### Seçim (Selected Index)

```dart
int _seciliIndeks = 0;

BottomNavigationBar(
  currentIndex: _seciliIndeks,
  onTap: (indeks) {
    setState(() => _seciliIndeks = indeks);
  },
  items: const [/*...*/],
)
```

---

## 7. Stateless mi, Stateful mi?

```
Sorunuz: "Bu widget'ın zamanla değişen verisi var mı?"

Evet → StatefulWidget
Hayır → StatelessWidget

Örnekler:
✅ Stateless:
  - Ürün kartı (veri dışarıdan gelir)
  - Profil sayfası başlığı
  - Hata mesajı widget'ı

✅ Stateful:
  - Sayaç
  - Form
  - Tab seçimi
  - Favori butonu (beğenildi/beğenilmedi)
  - Animasyonlar
  - Timer göstergesi
```

---

## Özet

```
StatefulWidget:
├── İki sınıf: Widget + State
├── State değişkenleri _ ile başlar
├── setState() → değişkeni güncelle + UI'ı yenile
└── Lifecycle:
    ├── initState()  → başlangıç işlemleri
    ├── build()      → UI çiz (setState'de tekrar çağrılır)
    └── dispose()    → temizlik (memory leak önleme)
```

---

## Alıştırmalar

1. 0'dan başlayan, artır/azalt/sıfırla butonları olan sayaç uygulaması yapın.
2. Karanlık/aydınlık mod geçişi yapan bir toggle ekranı oluşturun.
3. Görev listesi (To-Do): metin girişi, ekleme, tamamlandı işaretleme, silme.
4. Basit bir form: ad, email, şifre alanları; tümü dolu olmadan "Kaydet" butonunu devre dışı bırakın.
5. Dakika:saniye gösteren, start/stop/reset butonları olan kronometre yapın.

---

**Önceki Ders:** [Ders 03 — Layout Widget'ları](../Ders03_Layout_Widgetlari/ders_notu.md)
**Sonraki Ders:** [Ders 05 — Navigasyon](../Ders05_Navigasyon/ders_notu.md)
