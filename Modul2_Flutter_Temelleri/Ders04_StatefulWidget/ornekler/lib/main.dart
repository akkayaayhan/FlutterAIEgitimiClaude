// Ders 04 — StatefulWidget: Çalışan Örnek
// KURULUM: ornekler/ klasöründe → flutter pub get → flutter run

import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const UygulamaNokta());

class UygulamaNokta extends StatelessWidget {
  const UygulamaNokta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulWidget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _seciliSayfa = 0;

  final List<Widget> _sayfalar = const [
    _SayacSayfasi(),
    _TodoSayfasi(),
    _KronometreSayfasi(),
    _FormSayfasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulWidget Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _sayfalar[_seciliSayfa],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _seciliSayfa,
        onDestinationSelected: (i) => setState(() => _seciliSayfa = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.add_circle_outline), label: 'Sayaç'),
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Görevler'),
          NavigationDestination(icon: Icon(Icons.timer_outlined), label: 'Kronometre'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Form'),
        ],
      ),
    );
  }
}

// ── 1. Sayaç Sayfası ──────────────────────────────────────────────────

class _SayacSayfasi extends StatefulWidget {
  const _SayacSayfasi();

  @override
  State<_SayacSayfasi> createState() => _SayacSayfasiState();
}

class _SayacSayfasiState extends State<_SayacSayfasi> {
  int _sayac = 0;

  @override
  Widget build(BuildContext context) {
    final renk = _sayac > 0
        ? Colors.green
        : _sayac < 0
            ? Colors.red
            : Colors.grey;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_sayac',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: renk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _sayac == 0
                ? 'Sıfır'
                : _sayac > 0
                    ? 'Pozitif'
                    : 'Negatif',
            style: TextStyle(fontSize: 18, color: renk),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Azalt
              FloatingActionButton(
                heroTag: 'azalt',
                onPressed: () => setState(() => _sayac--),
                backgroundColor: Colors.red.shade100,
                child: const Icon(Icons.remove, color: Colors.red),
              ),
              const SizedBox(width: 24),
              // Sıfırla
              FloatingActionButton(
                heroTag: 'sifirla',
                onPressed: () => setState(() => _sayac = 0),
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.refresh, color: Colors.grey),
              ),
              const SizedBox(width: 24),
              // Artır
              FloatingActionButton(
                heroTag: 'artir',
                onPressed: () => setState(() => _sayac++),
                backgroundColor: Colors.green.shade100,
                child: const Icon(Icons.add, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── 2. To-Do Listesi ──────────────────────────────────────────────────

class _TodoSayfasi extends StatefulWidget {
  const _TodoSayfasi();

  @override
  State<_TodoSayfasi> createState() => _TodoSayfasiState();
}

class _TodoGorev {
  String metin;
  bool tamamlandi;
  _TodoGorev(this.metin, {this.tamamlandi = false});
}

class _TodoSayfasiState extends State<_TodoSayfasi> {
  final List<_TodoGorev> _gorevler = [
    _TodoGorev('Flutter öğren'),
    _TodoGorev('StatefulWidget kavra'),
    _TodoGorev('İlk uygulama yap'),
  ];
  final TextEditingController _kontrolcu = TextEditingController();

  @override
  void dispose() {
    _kontrolcu.dispose();
    super.dispose();
  }

  void _gorevEkle() {
    final metin = _kontrolcu.text.trim();
    if (metin.isEmpty) return;
    setState(() {
      _gorevler.add(_TodoGorev(metin));
      _kontrolcu.clear();
    });
  }

  void _gorevSil(int index) {
    setState(() => _gorevler.removeAt(index));
  }

  void _tamamlandiToggle(int index) {
    setState(() => _gorevler[index].tamamlandi = !_gorevler[index].tamamlandi);
  }

  @override
  Widget build(BuildContext context) {
    final tamamlananSayisi = _gorevler.where((g) => g.tamamlandi).length;

    return Column(
      children: [
        // İlerleme çubuğu
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.indigo.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$tamamlananSayisi / ${_gorevler.length} tamamlandı',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _gorevler.isEmpty ? 0 : tamamlananSayisi / _gorevler.length,
                backgroundColor: Colors.indigo.shade100,
                color: Colors.indigo,
              ),
            ],
          ),
        ),
        // Görev listesi
        Expanded(
          child: _gorevler.isEmpty
              ? const Center(child: Text('Henüz görev yok!'))
              : ListView.builder(
                  itemCount: _gorevler.length,
                  itemBuilder: (ctx, i) {
                    final gorev = _gorevler[i];
                    return Dismissible(
                      key: ValueKey(gorev.metin + i.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _gorevSil(i),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: gorev.tamamlandi,
                          onChanged: (_) => _tamamlandiToggle(i),
                        ),
                        title: Text(
                          gorev.metin,
                          style: TextStyle(
                            decoration: gorev.tamamlandi
                                ? TextDecoration.lineThrough
                                : null,
                            color: gorev.tamamlandi ? Colors.grey : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _gorevSil(i),
                        ),
                      ),
                    );
                  },
                ),
        ),
        // Yeni görev ekle
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _kontrolcu,
                  decoration: const InputDecoration(
                    hintText: 'Yeni görev...',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _gorevEkle(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _gorevEkle,
                icon: const Icon(Icons.add),
                label: const Text('Ekle'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── 3. Kronometre ────────────────────────────────────────────────────

class _KronometreSayfasi extends StatefulWidget {
  const _KronometreSayfasi();

  @override
  State<_KronometreSayfasi> createState() => _KronometreSayfasiState();
}

class _KronometreSayfasiState extends State<_KronometreSayfasi> {
  Timer? _timer;
  int _milisaniye = 0;
  bool _calisiyor = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _baslat() {
    setState(() => _calisiyor = true);
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() => _milisaniye += 10);
    });
  }

  void _durdur() {
    _timer?.cancel();
    setState(() => _calisiyor = false);
  }

  void _sifirla() {
    _timer?.cancel();
    setState(() {
      _calisiyor = false;
      _milisaniye = 0;
    });
  }

  String get _zamanMetni {
    final dk = _milisaniye ~/ 60000;
    final sn = (_milisaniye % 60000) ~/ 1000;
    final ms = (_milisaniye % 1000) ~/ 10;
    return '${dk.toString().padLeft(2, '0')}:'
        '${sn.toString().padLeft(2, '0')}.'
        '${ms.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _calisiyor ? Colors.indigo : Colors.grey.shade300,
                width: 6,
              ),
            ),
            child: Center(
              child: Text(
                _zamanMetni,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: _calisiyor ? Colors.indigo : Colors.grey.shade600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sıfırla
              OutlinedButton.icon(
                onPressed: _sifirla,
                icon: const Icon(Icons.refresh),
                label: const Text('Sıfırla'),
              ),
              const SizedBox(width: 16),
              // Başlat / Durdur
              ElevatedButton.icon(
                onPressed: _calisiyor ? _durdur : _baslat,
                icon: Icon(_calisiyor ? Icons.pause : Icons.play_arrow),
                label: Text(_calisiyor ? 'Durdur' : 'Başlat'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _calisiyor ? Colors.orange : Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── 4. Form Sayfası ──────────────────────────────────────────────────

class _FormSayfasi extends StatefulWidget {
  const _FormSayfasi();

  @override
  State<_FormSayfasi> createState() => _FormSayfasiState();
}

class _FormSayfasiState extends State<_FormSayfasi> {
  final _formKey = GlobalKey<FormState>();
  final _adKontrolcu = TextEditingController();
  final _emailKontrolcu = TextEditingController();
  final _sifreKontrolcu = TextEditingController();
  bool _sifreGoster = false;
  bool _kayitBasarili = false;

  @override
  void dispose() {
    _adKontrolcu.dispose();
    _emailKontrolcu.dispose();
    _sifreKontrolcu.dispose();
    super.dispose();
  }

  void _kaydet() {
    if (_formKey.currentState!.validate()) {
      setState(() => _kayitBasarili = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_kayitBasarili) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            Text(
              'Hoş geldiniz, ${_adKontrolcu.text}!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(_emailKontrolcu.text, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => setState(() => _kayitBasarili = false),
              child: const Text('Geri Dön'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Kayıt Ol',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Ad Soyad
            TextFormField(
              controller: _adKontrolcu,
              decoration: const InputDecoration(
                labelText: 'Ad Soyad',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Ad soyad zorunludur';
                if (v.length < 3) return 'En az 3 karakter olmalı';
                return null;
              },
            ),
            const SizedBox(height: 16),
            // E-posta
            TextFormField(
              controller: _emailKontrolcu,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-posta',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) return 'E-posta zorunludur';
                if (!v.contains('@')) return 'Geçerli bir e-posta girin';
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Şifre
            TextFormField(
              controller: _sifreKontrolcu,
              obscureText: !_sifreGoster,
              decoration: InputDecoration(
                labelText: 'Şifre',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_sifreGoster ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _sifreGoster = !_sifreGoster),
                ),
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Şifre zorunludur';
                if (v.length < 6) return 'En az 6 karakter olmalı';
                return null;
              },
            ),
            const SizedBox(height: 32),
            // Kaydet Butonu
            ElevatedButton(
              onPressed: _tumAlanlardoluMu() ? _kaydet : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Kayıt Ol', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  bool _tumAlanlardoluMu() =>
      _adKontrolcu.text.isNotEmpty &&
      _emailKontrolcu.text.isNotEmpty &&
      _sifreKontrolcu.text.isNotEmpty;
}
