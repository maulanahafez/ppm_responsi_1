class Ikan {
  String? id;
  String? nama;
  String? jenis;
  String? warna;
  String? habitat;
  Ikan({this.id, this.nama, this.jenis, this.warna, this.habitat});
  factory Ikan.fromJson(Map<String, dynamic> obj) {
    return Ikan(
      id: obj['id'],
      nama: obj['nama'],
      jenis: obj['jenis'],
      warna: obj['warna'],
      habitat: obj['habitat'],
    );
  }
}
