// Ders 02 — Formlar ve Input Widget'ları: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run

import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AnaSayfa(),
    );
  }
}

// ── Ana Sayfa (Sekmeli) ────────────────────────────────────────────

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Bileşenleri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.login), text: 'Giriş'),
            Tab(icon: Icon(Icons.person_add), text: 'Kayıt'),
            Tab(icon: Icon(Icons.tune), text: 'Tercihler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          GirisFormu(),
          KayitFormu(),
          TercihlerFormu(),
        ],
      ),
    );
  }
}

// ── 1. Giriş Formu ────────────────────────────────────────────────

class GirisFormu extends StatefulWidget {
  const GirisFormu({super.key});

  @override
  State<GirisFormu> createState() => _GirisFormuState();
}

class _GirisFormuState extends State<GirisFormu> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _sifreController = TextEditingController();
  bool _sifreGoster = false;
  bool _beniHatirla = false;
  bool _yukleniyor = false;

  @override
  void dispose() {
    _emailController.dispose();
    _sifreController.dispose();
    super.dispose();
  }

  Future<void> _girisYap() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _yukleniyor = true);

    // Simüle edilmiş API çağrısı
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _yukleniyor = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hoş geldiniz: ${_emailController.text}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            // Logo / başlık
            const Icon(Icons.flutter_dash, size: 64, color: Colors.deepPurple),
            const SizedBox(height: 8),
            const Text(
              'Giriş Yap',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // E-posta alanı
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-posta',
                hintText: 'ornek@email.com',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.deepPurple.shade50,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'E-posta boş bırakılamaz';
                if (!v.contains('@') || !v.contains('.')) return 'Geçerli bir e-posta girin';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Şifre alanı
            TextFormField(
              controller: _sifreController,
              obscureText: !_sifreGoster,
              decoration: InputDecoration(
                labelText: 'Şifre',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_sifreGoster ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _sifreGoster = !_sifreGoster),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.deepPurple.shade50,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Şifre boş bırakılamaz';
                if (v.length < 6) return 'Şifre en az 6 karakter olmalı';
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Beni hatırla
            CheckboxListTile(
              title: const Text('Beni hatırla'),
              value: _beniHatirla,
              onChanged: (v) => setState(() => _beniHatirla = v!),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),

            // Giriş butonu
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _yukleniyor ? null : _girisYap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _yukleniyor
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Giriş Yap', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),

            // Şifremi unuttum
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Şifre sıfırlama e-postası gönderildi')),
                );
              },
              child: const Text('Şifremi Unuttum'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 2. Kayıt Formu ────────────────────────────────────────────────

class KayitFormu extends StatefulWidget {
  const KayitFormu({super.key});

  @override
  State<KayitFormu> createState() => _KayitFormuState();
}

class _KayitFormuState extends State<KayitFormu> {
  final _formKey = GlobalKey<FormState>();
  final _adController = TextEditingController();
  final _emailController = TextEditingController();
  final _sifreController = TextEditingController();
  final _sifreTekrarController = TextEditingController();
  bool _sifreGoster = false;
  bool _sozlesmeKabul = false;
  String? _seciliSehir;

  final List<String> _sehirler = ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Diğer'];

  @override
  void dispose() {
    _adController.dispose();
    _emailController.dispose();
    _sifreController.dispose();
    _sifreTekrarController.dispose();
    super.dispose();
  }

  void _kayitOl() {
    if (!_sozlesmeKabul) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanım koşullarını kabul etmelisiniz'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_adController.text} olarak kayıt başarılı!'),
          backgroundColor: Colors.green,
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _sozlesmeKabul = false;
        _seciliSehir = null;
      });
      _adController.clear();
      _emailController.clear();
      _sifreController.clear();
      _sifreTekrarController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ad Soyad
            TextFormField(
              controller: _adController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Ad Soyad',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Ad Soyad boş bırakılamaz';
                if (v.trim().length < 3) return 'En az 3 karakter girin';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // E-posta
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-posta',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'E-posta boş bırakılamaz';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Geçerli e-posta girin';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Şehir dropdown
            DropdownButtonFormField<String>(
              initialValue: _seciliSehir,
              decoration: InputDecoration(
                labelText: 'Şehir',
                prefixIcon: const Icon(Icons.location_city_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _sehirler
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _seciliSehir = v),
              validator: (v) => v == null ? 'Şehir seçiniz' : null,
            ),
            const SizedBox(height: 14),

            // Şifre
            TextFormField(
              controller: _sifreController,
              obscureText: !_sifreGoster,
              decoration: InputDecoration(
                labelText: 'Şifre',
                prefixIcon: const Icon(Icons.lock_outline),
                helperText: 'En az 6 karakter, harf ve rakam içermeli',
                suffixIcon: IconButton(
                  icon: Icon(_sifreGoster ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _sifreGoster = !_sifreGoster),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (v) {
                if (v == null || v.length < 6) return 'En az 6 karakter olmalı';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Şifre tekrar
            TextFormField(
              controller: _sifreTekrarController,
              obscureText: !_sifreGoster,
              decoration: InputDecoration(
                labelText: 'Şifre Tekrar',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (v) {
                if (v != _sifreController.text) return 'Şifreler eşleşmiyor';
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Kullanım koşulları
            CheckboxListTile(
              title: const Text('Kullanım koşullarını kabul ediyorum'),
              value: _sozlesmeKabul,
              onChanged: (v) => setState(() => _sozlesmeKabul = v!),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _kayitOl,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Kayıt Ol', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 3. Tercihler Formu ────────────────────────────────────────────

class TercihlerFormu extends StatefulWidget {
  const TercihlerFormu({super.key});

  @override
  State<TercihlerFormu> createState() => _TercihlerFormuState();
}

class _TercihlerFormuState extends State<TercihlerFormu> {
  bool _emailBildirim = true;
  bool _pushBildirim = false;
  String _tema = 'acik';
  String _dil = 'turkce';
  double _fontBoyutu = 14;

  void _kaydet() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tercihler kaydedildi'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Bildirimler bölümü
        _bolumBasligi('Bildirimler'),
        SwitchListTile(
          title: const Text('E-posta Bildirimleri'),
          subtitle: const Text('Günlük özet ve güncellemeler'),
          value: _emailBildirim,
          onChanged: (v) => setState(() => _emailBildirim = v),
          activeThumbColor: Colors.deepPurple,
        ),
        SwitchListTile(
          title: const Text('Push Bildirimleri'),
          subtitle: const Text('Anlık bildirimler'),
          value: _pushBildirim,
          onChanged: (v) => setState(() => _pushBildirim = v),
          activeThumbColor: Colors.deepPurple,
        ),
        const Divider(height: 24),

        // Görünüm bölümü
        _bolumBasligi('Görünüm'),
        RadioGroup<String>(
          groupValue: _tema,
          onChanged: (v) => setState(() => _tema = v ?? _tema),
          child: const Column(
            children: [
              RadioListTile<String>(
                title: Text('Açık Tema'),
                subtitle: Text('Beyaz arka plan'),
                value: 'acik',
              ),
              RadioListTile<String>(
                title: Text('Koyu Tema'),
                subtitle: Text('Gözleri yoran koyu arka plan'),
                value: 'koyu',
              ),
              RadioListTile<String>(
                title: Text('Sistem Teması'),
                subtitle: Text('Cihaz ayarına göre'),
                value: 'sistem',
              ),
            ],
          ),
        ),
        const Divider(height: 24),

        // Yazı boyutu
        _bolumBasligi('Yazı Boyutu'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const Icon(Icons.text_fields, size: 18),
              Expanded(
                child: Slider(
                  value: _fontBoyutu,
                  min: 10,
                  max: 22,
                  divisions: 12,
                  label: '${_fontBoyutu.round()} pt',
                  onChanged: (v) => setState(() => _fontBoyutu = v),
                  activeColor: Colors.deepPurple,
                ),
              ),
              const Icon(Icons.text_fields, size: 26),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Örnek metin: Flutter ile uygulama geliştiriyorum',
            style: TextStyle(fontSize: _fontBoyutu),
          ),
        ),
        const Divider(height: 24),

        // Dil seçimi
        _bolumBasligi('Dil'),
        RadioGroup<String>(
          groupValue: _dil,
          onChanged: (v) => setState(() => _dil = v ?? _dil),
          child: const Column(
            children: [
              RadioListTile<String>(title: Text('Türkçe'), value: 'turkce'),
              RadioListTile<String>(title: Text('English'), value: 'english'),
              RadioListTile<String>(title: Text('Deutsch'), value: 'deutsch'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Kaydet butonu
        ElevatedButton.icon(
          onPressed: _kaydet,
          icon: const Icon(Icons.save),
          label: const Text('Tercihleri Kaydet', style: TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        baslik.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          color: Colors.deepPurple.shade600,
        ),
      ),
    );
  }
}
