import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor MuzikUygulamasi {

  /**
   * Türler
   */

  // Şarkı kimliği türü
  public type SarkiId = Nat32;

  // Şarkı türü
  public type Sarki = {
    ad : Text;
    sanatci : Text;
    album : Text;
    tur : Text; // Örneğin: Pop, Rock, Hiphop
    yil : Nat32; // Yayın yılı
    puan : Nat32; // 1-5 arasında kullanıcı puanı
  };

  /**
   * Uygulama Durumu
   */

  // Bir sonraki kullanılabilir şarkı kimliği
  private stable var next : SarkiId = 0;

  // Şarkı veritabanı
  private stable var sarkilar : Trie.Trie<SarkiId, Sarki> = Trie.empty();

  /**
   * Yüksek Seviye API
   */

  // Şarkı oluşturma
  public func create(sarki : Sarki) : async SarkiId {
    let sarkiId = next;
    next += 1;
    sarkilar := Trie.replace(
      sarkilar,
      key(sarkiId),
      Nat32.equal,
      ?sarki,
    ).0;
    return sarkiId;
  };

  // Şarkı okuma
  public query func read(sarkiId : SarkiId) : async ?Sarki {
    let result = Trie.find(sarkilar, key(sarkiId), Nat32.equal);
    return result;
  };

  // Şarkı güncelleme
  public func update(sarkiId : SarkiId, sarki : Sarki) : async Bool {
    let result = Trie.find(sarkilar, key(sarkiId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      sarkilar := Trie.replace(
        sarkilar,
        key(sarkiId),
        Nat32.equal,
        ?sarki,
      ).0;
    };
    return exists;
  };

  // Şarkı silme
  public func delete(sarkiId : SarkiId) : async Bool {
    let result = Trie.find(sarkilar, key(sarkiId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      sarkilar := Trie.replace(
        sarkilar,
        key(sarkiId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Yardımcı Fonksiyonlar
   */

  // Şarkı kimliği için bir anahtar oluşturma
  private func key(x : SarkiId) : Trie.Key<SarkiId> {
    return { hash = x; key = x };
  };
};
