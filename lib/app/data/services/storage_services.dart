
import 'package:get_storage/get_storage.dart';

class StorageService {
  final storage = GetStorage();
  
  // Keys untuk storage
  static const String KEY_MITRA_CODE = 'mitra_code';
  static const String KEY_MITRA_DATA = 'mitra_data';
  static const String KEY_IS_LOGGED_IN = 'is_logged_in';

  // Simpan data mitra
  Future<void> saveMitraData(Map<String, dynamic> mitraData) async {
    await storage.write(KEY_MITRA_DATA, mitraData);
    await storage.write(KEY_MITRA_CODE, mitraData['code']);
    await storage.write(KEY_IS_LOGGED_IN, true);
  }

  // Ambil code mitra
  String? getMitraCode() {
    return storage.read(KEY_MITRA_CODE);
  }

  // Ambil semua data mitra
  Map<String, dynamic>? getMitraData() {
    return storage.read(KEY_MITRA_DATA);
  }

  // Cek status login
  bool isLoggedIn() {
    return storage.read(KEY_IS_LOGGED_IN) ?? false;
  }

  // Hapus data saat logout
  Future<void> clearMitraData() async {
    await storage.remove(KEY_MITRA_DATA);
    await storage.remove(KEY_MITRA_CODE);
    await storage.write(KEY_IS_LOGGED_IN, false);
  }
}