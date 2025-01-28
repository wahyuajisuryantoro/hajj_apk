import 'package:get/get.dart';

class KebijakanPrivasiController extends GetxController {
  final RxString privacyContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPrivacyContent();
  }

  void loadPrivacyContent() {
    privacyContent.value = '''
**Kebijakan Privasi Hasanah Tour and Travel**

Kebijakan Privasi ini dibuat untuk menunjukkan komitmen kami terhadap perlindungan privasi setiap pengunjung website ini. Silahkan dibaca dengan seksama. Kami menghargai privasi Anda dan berkomitmen untuk melindungi informasi pribadi Anda. Kebijakan privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda ketika Anda menggunakan website dan bergabung menjadi agen kami.

**Cakupan Kebijakan Privasi**

Kami hanya akan menyimpan informasi Anda selama dibutuhkan atau selama informasi tersebut berhubungan dengan tujuan-tujuan yang ada saat informasi dikumpulkan. Anda dapat mengunjungi website ini dan melihat-lihat tanpa harus meninggalkan informasi pribadi. Saat Anda mengunjungi website ini, Anda memiliki status anonim yang tidak akan bisa kami identiifikasi kecuali Anda login menggunakan email dan password Anda.

Kebijakan privasi kami mengikuti kebijakan perundangan-undangan yang berlaku. Bila Anda memiliki komentar dan masukan, kami dengan senang hati menerimanya melalui halaman https://www.hasanahtours.com/kritik-saran.

**Pengumpulan Informasi**

Kami mengumpulkan informasi pribadi Anda ketika Anda:
1. Menghubungi kami melalui email atau telepon
2. Mendaftar sebagai agen
3. Menggunakan sistem keagenan kami

Informasi yang kami kumpulkan termasuk:
1. Nama dan alamat email
2. Nomor telepon dan alamat

**Penggunaan Informasi**

Kami menggunakan informasi pribadi Anda untuk:
1. Mengelola akun agen Anda
2. Mengirimkan informasi tentang produk dan layanan kami
3. Meningkatkan kualitas sistem keagenan kami

**Perlindungan Informasi**

Kami berkomitmen untuk melindungi informasi pribadi Anda dengan:
1. Menggunakan teknologi enkripsi yang aman
2. Membatasi akses ke informasi pribadi Anda hanya untuk orang yang berwenang
3. Mengikuti pedoman keamanan data yang ketat

**Pengungkapan Informasi**

Kami tidak akan mengungkapkan informasi pribadi Anda kepada pihak ketiga tanpa izin Anda, kecuali dalam kasus-kasus berikut:
1. Untuk mematuhi hukum dan peraturan yang berlaku
2. Untuk melindungi hak-hak kami atau pihak ketiga

**Hak-Hak Anda**

Anda memiliki hak-hak berikut:
1. Mengakses dan memperbarui informasi pribadi Anda
2. Menghapus informasi pribadi Anda
3. Mengajukan keluhan tentang penggunaan informasi pribadi Anda

**Informasi yang Dikumpulkan oleh Teknologi**

**Cookies**
Cookies adalah data yang disimpan di komputer pengguna yang berkaitan dengan informasi pengguna tersebut. Cookies ini digunakan untuk mempermudah anda seperti mengingat password secara otomatis dan manajemen session. Kami juga menggunakan cookies untuk keperluan statistik pengunjung. Mengetahui berapa jumlah pengunjung, waktu berkunjung, halaman yang dibuka pengunjung, serta berapa lama pengunjung browsing di website ini. Analisa statistik tersebut kami gunakan untuk meningkatkan kualitas website ini agar semakin sesuai dengan kebutuhan pengunjung.

Anda bisa memilih untuk menerima atau menolak cookies. Semua web browser secara otomatis menerima cookies, tetapi anda bisa memodifikasi untuk menolaknya jika anda tidak menginginkannya. Namun menolak cookies memungkinkan anda untuk tidak bisa menikmati keseluruhan fitur dan kemudahan yang ada di website ini. Kami tidak pernah menggunakan cookies untuk mengumpulkan data pribadi anda yang tidak ingin anda berikan kepada kami.

**IP Addresses**
IP address merupakan deretan angka unik yang dipakai sebagai identifikasi tiap komputer host dalam jaringan internet. Kami merecord setiap IP address pengguna untuk keperluan statistik pengunjung, analisa trend, dan analisa demografi. Record IP address tidak pernah digunakan untuk mengidentifikasi informasi personal pengunjung.

**Penggunaan Alamat Email**
Kami tidak akan pernah membagi, menjual, menyewakan, menukar atau memberikan wewewenang kepada pihak ketiga tanpa persetujuan anda. Jika anda merasa telah menerima email dari kami karena suatu kesalahan, anda bisa melaporkannya ke https://www.hasanahtours.com/kritik-saran.

**Email Newsletter**
Jika anda berlangganan artikel website ini, maka anda akan menerima email setiap ada konten baru yang diterbitkan. Jika anda tidak lagi menginginkannya, anda bisa klik "Unsubscribe" di sudut bawah setiap newsletter.

**Perubahan Kebijakan Privasi**
Kami berhak untuk memperbarui kebijakan privasi ini sewaktu-waktu. Perubahan akan berlaku efektif setelah kami mempublikasikan perubahan tersebut di situs web kami.

Tidak ada kewajiban kami untuk menginformasikan setiap perubahan sehingga Pengguna bersedia untuk memeriksa Kebijakan Privasi ini secara berkala agar perubahannya dapat diketahui. Dengan tetap mengakses dan menggunakan layanan kami, maka Pengguna dianggap menyetujui perubahan-perubahan dalam Kebijakan Privasi.
''';
  }
}