# album-app


MuzikUygulamasi, kullanıcıların şarkı veritabanında şarkı eklemesine, okumasına, güncellemesine ve silmesine olanak tanıyan bir **Actor**'dür. Uygulama, şarkıların bilgilerini saklamak için `Trie` veri yapısını kullanır.

Bu proje, **Motoko** dilinde yazılmıştır ve **Internet Computer** platformunda çalışacak şekilde tasarlanmıştır.

## Özellikler

- **Şarkı oluşturma:** Yeni şarkılar ekleyebilirsiniz.
- **Şarkı okuma:** Veritabanındaki şarkı bilgilerine erişebilirsiniz.
- **Şarkı güncelleme:** Mevcut şarkıları güncelleyebilirsiniz.
- **Şarkı silme:** Şarkıları veritabanından silebilirsiniz.

## Türler

### `Sarki`
Her şarkının aşağıdaki bilgileri içerdiği bir türdür:
- `ad` (Text): Şarkının adı.
- `sanatci` (Text): Şarkının sanatçısı.
- `album` (Text): Şarkının albümü.
- `tur` (Text): Şarkı türü (örneğin: Pop, Rock, Hiphop).
- `yil` (Nat32): Şarkının yayın yılı.
- `puan` (Nat32): Kullanıcı puanı (1-5 arasında).

### `SarkiId`
Şarkının benzersiz kimliği (Nat32 türünde).

## API

### `create(sarki : Sarki) : async SarkiId`
Yeni bir şarkı oluşturur. Şarkı veritabanına eklenir ve şarkı kimliği döndürülür.

**Örnek Kullanım:**
```motoko
let sarki = {
  ad = "Shape of You";
  sanatci = "Ed Sheeran";
  album = "Divide";
  tur = "Pop";
  yil = 2017;
  puan = 5;
};
let sarkiId = await muzikUygulamasi.create(sarki);
