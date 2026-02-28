# Ders 02 — Formlar ve Input Widget'ları

## Bu Derste Neler Öğreneceğiz?
- `TextField` ve `TextFormField` kullanımı
- `TextEditingController` ile metin yönetimi
- Form doğrulama (`Form`, `GlobalKey<FormState>`, `validator`)
- `InputDecoration` ile stil verme
- Farklı klavye tipleri (`keyboardType`)
- Şifre alanı (`obscureText`)
- `DropdownButtonFormField`, `Checkbox`, `Switch`, `Radio`, `Slider`
- Form gönderme akışı

---

## 1. TextField — Temel Metin Girişi

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Ad Soyad',
    hintText: 'Adınızı girin',
    prefixIcon: const Icon(Icons.person),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  onChanged: (deger) {
    print('Girilen: $deger');
  },
)
```

### Önemli TextField parametreleri:

| Parametre | Açıklama |
|-----------|----------|
| `controller` | `TextEditingController` bağla |
| `keyboardType` | Klavye tipi (metin, sayı, e-posta…) |
| `obscureText` | Şifre için gizleme |
| `maxLines` | Çok satır (null = sınırsız) |
| `maxLength` | Maksimum karakter |
| `onChanged` | Her tuş basımında tetiklenir |
| `onSubmitted` | Enter/Done basımında tetiklenir |
| `enabled` | Aktif/pasif |
| `autofocus` | Otomatik odak |

---

## 2. TextEditingController

Metin alanının değerini programatik olarak okumak/değiştirmek için:

```dart
class _FormSayfasiState extends State<FormSayfasi> {
  final _adController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için mutlaka dispose edilmeli!
    _adController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _formuGonder() {
    final ad = _adController.text.trim();
    final email = _emailController.text.trim();
    print('Ad: $ad, Email: $email');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _adController,
          decoration: const InputDecoration(labelText: 'Ad'),
        ),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'E-posta'),
          keyboardType: TextInputType.emailAddress,
        ),
        ElevatedButton(
          onPressed: _formuGonder,
          child: const Text('Gönder'),
        ),
      ],
    );
  }
}
```

> **Önemli:** `Controller` nesneleri `dispose()` içinde temizlenmelidir.

---

## 3. Klavye Tipleri

```dart
// Metin (varsayılan)
keyboardType: TextInputType.text

// E-posta (@, .com)
keyboardType: TextInputType.emailAddress

// Telefon (+, rakamlar)
keyboardType: TextInputType.phone

// Sayı (rakamlar)
keyboardType: TextInputType.number

// URL
keyboardType: TextInputType.url

// Çok satırlı metin
keyboardType: TextInputType.multiline
maxLines: null   // veya 5, 10 gibi bir sayı
```

---

## 4. Form ve Doğrulama (Validation)

`Form` widget'ı, birden fazla `TextFormField`'ı gruplayarak toplu doğrulama sağlar:

```dart
class _KayitFormuState extends State<KayitFormu> {
  final _formKey = GlobalKey<FormState>();  // Formun kimliği
  final _adController = TextEditingController();
  final _emailController = TextEditingController();
  final _sifreController = TextEditingController();

  void _kayitOl() {
    // validate() — tüm validator'ları çalıştırır
    if (_formKey.currentState!.validate()) {
      // Tüm alanlar geçerli → işlemi gerçekleştir
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıt başarılı!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _adController,
            decoration: const InputDecoration(
              labelText: 'Ad Soyad',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (deger) {
              if (deger == null || deger.isEmpty) {
                return 'Ad Soyad boş bırakılamaz';
              }
              if (deger.length < 3) {
                return 'En az 3 karakter olmalı';
              }
              return null;  // null = geçerli
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'E-posta',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (deger) {
              if (deger == null || deger.isEmpty) {
                return 'E-posta boş bırakılamaz';
              }
              if (!deger.contains('@')) {
                return 'Geçerli bir e-posta girin';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _sifreController,
            decoration: const InputDecoration(
              labelText: 'Şifre',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,    // Şifre gizleme
            validator: (deger) {
              if (deger == null || deger.length < 6) {
                return 'Şifre en az 6 karakter olmalı';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _kayitOl,
              child: const Text('Kayıt Ol'),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 5. InputDecoration — Stil Seçenekleri

```dart
InputDecoration(
  // Etiketler
  labelText: 'Ad',              // Üste çıkan etiket
  hintText: 'Adınızı girin',    // Placeholder
  helperText: 'Resmi adınız',   // Alt açıklama
  errorText: 'Hata mesajı',     // Kırmızı hata (null ise gizli)

  // İkonlar
  prefixIcon: const Icon(Icons.person),
  suffixIcon: const Icon(Icons.clear),
  prefix: const Text('₺'),      // Metin prefix
  suffix: const Text('TL'),     // Metin suffix

  // Kenarlık tipleri
  border: const OutlineInputBorder(),          // Her durumda kenarlık
  enabledBorder: OutlineInputBorder(           // Normal durumda
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(           // Odaklanıldığında
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
  errorBorder: OutlineInputBorder(             // Hata durumunda
    borderSide: BorderSide(color: Colors.red),
  ),

  // Dolgu rengi
  filled: true,
  fillColor: Colors.grey.shade50,
)
```

---

## 6. Diğer Input Widget'ları

### Checkbox

```dart
bool _kabul = false;

CheckboxListTile(
  title: const Text('Kullanım koşullarını kabul ediyorum'),
  value: _kabul,
  onChanged: (deger) => setState(() => _kabul = deger!),
  controlAffinity: ListTileControlAffinity.leading,  // Sola al
)
```

### Switch

```dart
bool _bildirimler = true;

SwitchListTile(
  title: const Text('Bildirimleri Aç'),
  subtitle: const Text('Yeni mesajlarda bildir'),
  value: _bildirimler,
  onChanged: (deger) => setState(() => _bildirimler = deger),
  activeColor: Colors.indigo,
)
```

### Radio

```dart
String _cinsiyet = 'erkek';

Column(
  children: [
    RadioListTile<String>(
      title: const Text('Erkek'),
      value: 'erkek',
      groupValue: _cinsiyet,
      onChanged: (v) => setState(() => _cinsiyet = v!),
    ),
    RadioListTile<String>(
      title: const Text('Kadın'),
      value: 'kadin',
      groupValue: _cinsiyet,
      onChanged: (v) => setState(() => _cinsiyet = v!),
    ),
  ],
)
```

### Slider

```dart
double _yas = 25;

Slider(
  value: _yas,
  min: 18,
  max: 65,
  divisions: 47,       // Adım sayısı
  label: '${_yas.round()} yaş',
  onChanged: (deger) => setState(() => _yas = deger),
)
```

### DropdownButtonFormField

```dart
String? _sehir;

DropdownButtonFormField<String>(
  value: _sehir,
  decoration: const InputDecoration(
    labelText: 'Şehir',
    border: OutlineInputBorder(),
  ),
  items: ['İstanbul', 'Ankara', 'İzmir', 'Bursa']
      .map((sehir) => DropdownMenuItem(
            value: sehir,
            child: Text(sehir),
          ))
      .toList(),
  onChanged: (deger) => setState(() => _sehir = deger),
  validator: (deger) => deger == null ? 'Şehir seçin' : null,
)
```

---

## 7. Form Sıfırlama

```dart
// Formu sıfırla (tüm alanları temizle ve hataları kaldır)
_formKey.currentState!.reset();

// Sadece controller'ları temizle
_adController.clear();
_emailController.clear();
```

---

## Form Akışı Özeti

```
Kullanıcı form doldurur
        ↓
"Gönder" butonuna basar
        ↓
_formKey.currentState!.validate()
        ↓
    ┌───┴───┐
  false    true
    ↓        ↓
  Hata     İşlemi
 mesajları gerçekleştir
 gösterilir
```

---

## Alıştırmalar

1. Ad, soyad, e-posta ve şifre alanlarından oluşan bir kayıt formu yapın. Tüm alanlar için `validator` yazın.
2. Şifre alanına göz ikonu ekleyin. Butona tıklanınca `obscureText` değiştirilerek şifre görünür/gizli hale gelsin.
3. Bir profil güncelleme formu yapın: Ad, biyografi (çok satırlı), şehir (dropdown), cinsiyet (radio), bildirimler (switch). Kaydet butonuna basınca SnackBar gösterin.
4. Slider ile 1-10 arası puan veren bir geri bildirim formu yapın.

---

**Önceki Ders:** [Ders 01 — Material Design Bileşenleri](../Ders01_Material_Tasarim/ders_notu.md)
**Sonraki Ders:** [Ders 03 — Liste Görünümleri](../Ders03_Liste_Gorunumleri/ders_notu.md)
