import 'dart:convert';

import 'package:ppm_responsi_1/helpers/api.dart';
import 'package:ppm_responsi_1/helpers/api_url.dart';
import 'package:ppm_responsi_1/model/ikan.dart';

class IkanBloc {
  static Future<List<Ikan>> getIkans() async {
    String apiUrl = ApiUrl.listIkan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Ikan> ikans = [];
    for (int i = 0; i < listProduk.length; i++) {
      ikans.add(Ikan.fromJson(listProduk[i]));
    }
    return ikans;
  }

  static Future<bool> addIkan({Ikan? ikan}) async {
    String apiUrl = ApiUrl.createIkan;
    var body = {
      // "id": ikan!.id,
      "nama": ikan!.nama,
      "jenis": ikan.jenis,
      "warna": ikan.warna,
      "habitat": ikan.habitat,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateIkan({required Ikan ikan}) async {
    String apiUrl = ApiUrl.updateIkan(ikan.id!);
    var body = {
      "id": ikan.id,
      "nama": ikan.nama,
      "jenis": ikan.jenis,
      "warna": ikan.warna,
      "habitat": ikan.habitat,
    };
    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteIkan(String? id) async {
    String apiUrl = ApiUrl.deleteIkan(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
