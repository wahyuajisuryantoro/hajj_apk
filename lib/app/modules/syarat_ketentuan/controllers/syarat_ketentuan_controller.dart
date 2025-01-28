import 'package:get/get.dart';

class SyaratKetentuanController extends GetxController {
  final RxString termsContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTermsContent();
  }

  void loadTermsContent() {
    termsContent.value = '''
**Syarat dan Ketentuan Hasanah Tour and Travel**

Selamat datang di hasanahtours.com, terima kasih telah mengunjungi website kami. Luangkan waktu Anda untuk membaca Syarat dan Ketentuan ini sebelum memesan layanan kami dan bergabung menjadi agen dari Hasanah Tours and Travel. Dengan memesan paket dan layanan kami, berarti Anda setuju untuk terikat pada Syarat dan Ketentuan ini. Anda harus mengunjungi halaman secara berkala untuk mengetahui setiap perubahan yang kami buat dalam Syarat dan Ketentuan kami.

**Tentang Kami**

**PT. ASYESA** merupakan pemilik dan pengelola website hasanahtours.com. Berawal dari pengalaman Asaatidz dan kolega di kantor yang berkesempatan ziarah ke Tanah Suci baik haji ataupun umroh, adanya ketidakpuasan jamaah terhadap berbagai layanan yang diberikan Biro Travel menjadikan semangat untuk bisa menghadirkan layanan tour dan travel yang mampu memberikan pelayanan dan kepuasan bagi jamaah.

**1. Definisi**
- "Jamaah" berarti Anda yang melakukan pemesanan paket umroh.
- "Paket Umroh" berarti perjalanan umroh yang kami tawarkan.
- "Pemesanan" berarti proses pemesanan paket umroh yang dilakukan oleh Anda.
- "Agen" berarti individu atau badan yang telah mendaftar sebagai agen Hasanahtours.
- "Sistem Keagenan" berarti sistem yang digunakan oleh Perusahaan untuk mengelola kegiatan keagenan.
- "Perusahaan" adalah PT. ASYESA atau hasanahtours.com

**2. Pendaftaran Umroh**
- Calon Jamaah melakukan pemesanan sesuai paket yang diinginkan yang tertera di website dan kemudian diarahkan ke nomor whatsapp Hasanah.
- Anda harus mengisi formulir pemesanan dengan lengkap dan akurat.
- Pemesanan dianggap sah apabila calon jamaah telah membayar biaya paket umroh / DP.

**3. Pembayaran**
- Pembayaran harus dilakukan sebelum tanggal keberangkatan.
- Biaya paket umroh harus dibayar penuh.

**4. Pengembalian Dana**
- Pengembalian dana hanya dapat dilakukan jika ada kesalahan dari pihak kami.
- Pengembalian dana akan diproses dalam waktu 7 hari kerja.

**5. Tanggung Jawab terhadap Jamaah**
- Kami tidak bertanggung jawab atas kerugian atau kerusakan yang dialami oleh jamaah selama perjalanan umroh.
- Kami tidak bertanggung jawab atas keterlambatan atau pembatalan penerbangan maskapai.

**6. Pendaftaran Agen**
- Agen harus mendaftar secara online melalui situs web hasanahtours.com/agen#pendaftaran-agen.
- Agen harus menyediakan informasi yang akurat dan lengkap saat mendaftar.
- Kami berhak untuk menolak atau menerima pendaftaran agen.

**7. Penggunaan Sistem**
- Agen hanya dapat menggunakan sistem keagenan untuk tujuan yang sah dan sesuai dengan kebijakan Perusahaan.
- Agen tidak boleh menggunakan sistem keagenan untuk melakukan aktivitas ilegal atau tidak etis.
- Perusahaan berhak untuk memantau dan mengawasi penggunaan sistem keagenan oleh agen.

**8. Kerahasiaan**
- Agen harus menjaga kerahasiaan informasi yang diperoleh melalui sistem keagenan.
- Agen tidak boleh mengungkapkan informasi tersebut kepada pihak ketiga tanpa izin Perusahaan.

**9. Hak Cipta**
- Perusahaan memiliki hak cipta atas sistem keagenan dan semua konten yang terkait.
- Agen tidak boleh menggandakan, memodifikasi, atau mendistribusikan sistem keagenan atau konten yang terkait tanpa izin Perusahaan.

**10. Tanggung Jawab Keagenan**
- Agen bertanggung jawab atas semua aktivitas yang dilakukan melalui sistem keagenan.
- Perusahaan tidak bertanggung jawab atas kerugian atau kerusakan yang dialami oleh agen atau pihak ketiga sebagai akibat dari kesalahan penggunaan sistem keagenan yang tidak sesuai.

**11. Penyelesaian Sengketa**
- Semua sengketa yang timbul dari pemesanan paket umroh dan penggunaan sistem keagenan akan diselesaikan melalui musyawarah dan mufakat.
- Jika sengketa tidak dapat diselesaikan melalui musyawarah dan mufakat, maka sengketa tersebut akan diselesaikan melalui pengadilan yang berwenang.

Syarat dan ketentuan dapat berubah sewaktu-waktu apabila diperlukan dengan kewenangan penuh hasanahtours.com atau perusahaan. Tidak ada kewajiban bagi kami untuk menginformasikan setiap perubahan, sehingga calon jamaah dan agen harus bersedia untuk memeriksa Syarat & Ketentuan ini secara berkala agar perubahannya dapat diketahui. Dengan melakukan pemesanan dan mendaftar sebagai agen, maka dianggap menyetujui perubahan-perubahan dalam Syarat & Ketentuan ini.
''';
  }
}