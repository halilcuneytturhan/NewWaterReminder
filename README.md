# Su Hatırlatıcısı 💧

Flutter ile geliştirilmiş kişisel su takip ve hatırlatma uygulaması. Günlük su içme hedefi belirlemenizi, içilen su miktarını takip etmenizi ve sürenizi yönetmenizi sağlar.

---

## 🚀 Özellikler

- 🔐 Kayıt olma ve giriş yapma
- 👤 Profil görüntüleme ve düzenleme
- 💧 Günlük su içme hedefi belirleme ve takip
- ⏱ 18 saatlik **geri sayım** süresi
- 🎉 Hedef tamamlandığında otomatik tebrik bildirimi
- 🌗 Tema değiştirme (açık/karanlık mod)
- 🖼 Arka plan görselleri ile modern ve sade tasarım
- 🧠 SQLite veritabanı ile kalıcı kullanıcı verileri

---

## 🧱 Yapı

- `main.dart`: Uygulama başlatıcı
- `login_screen.dart`: Giriş ekranı
- `register_screen.dart`: Kayıt ekranı
- `home_screen.dart`: Ana su takibi ve sayaç ekranı
- `profile_screen.dart`: Kullanıcı bilgileri ve profil düzenleme bağlantısı
- `edit_profile_screen.dart`: Kullanıcı adı, şifre ve hedef güncelleme
- `settings_screen.dart`: Ayarlar
- `user_model.dart`: Kullanıcı model sınıfı
- `user_db.dart`: SQLite tabanlı kullanıcı veritabanı yöneticisi

---

## 🕹 Kullanım

1. Uygulamayı aç
2. Kayıt olarak profil oluştur
3. Günlük hedefini belirle
4. Su içtikçe `+0.25 L içtim` butonuna bas
5. Kalan süreyi takip et — 18 saatlik geri sayım çalışır
6. Hedef tamamlandığında uygulama seni kutlar!

---

## 💾 Veritabanı

Veritabanı `users.db` dosyasında SQLite ile saklanır. Tabloda aşağıdaki alanlar bulunur:

- `id`
- `username`
- `password`
- `dailyGoal`
- `consumedWater`

---

## 🧪 Geliştirme Notları

- Süre `initState()` ile başlar ve her saniye `setState` ile güncellenir.
- Geri sayım süresi sabittir: `64800 saniye = 18 saat`
- Gece sıfırlama veya veri geçmişi şu an dahil edilmedi, istenirse eklenebilir.

---


## 📄 Lisans

Bu proje tamamen geliştiriciye aittir. Dilediğin gibi kullan, geliştir, paylaş. Kodun ruhu özgürdür.

