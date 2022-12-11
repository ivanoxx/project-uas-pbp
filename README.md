# PROYEK UAS A05 PBP 2022/2023 Gasal
[![Build status](https://build.appcenter.ms/v0.1/apps/c263908d-305a-4945-8807-31557f28db4f/branches/main/badge)](https://appcenter.ms)
[![Download](https://img.shields.io/badge/appcenter-download-blueviolet)](https://install.appcenter.ms/orgs/project-uas-pbp/apps/whistleblower/distribution_groups/public)
## Anggota Kelompok
1. Dafi Nafidz Radhiyya - 2106701564
2. Andi Muhamad Dzaky Raihan - 2106631412
3. Andi Ayuna Rymang - 2106637265
4. Tm Revanza Narendra Pradipta - 2206025003
5. Munifah Nurfadhilah - 2106654851

## Deskripsi Aplikasi
### Nama aplikasi  : [Whistleblower](https://whistle-blower.up.railway.app/)
### Fungsi aplikasi: Memberikan wadah kepada para saksi yang berani mengungkapkan kejahatan pelaku korupsi
### Peran/aktor pengguna aplikasi
1. Reader (Pengguna tanpa login)
    * Timeline Forum

2. Author (Pengguna dengan login)
    * Timeline forum 
    * Upvote forum
    * Komentar forum
    * Delete forum
    * Menambahkan kategori forum
    * Membuat post-an sebuah forum
    * Melihat halaman Hall of Shame 
    * Melihat profile
    * Melihat kumpulan my post

3. Admin (superuser)
    * Timeline forum 
    * Upvote forum
    * Komentar forum
    * Delete forum
    * Menambahkan kategori forum
    * Membuat post-an sebuah forum
    * Melihat halaman Hall of Shame 
    * Melihat profile
    * Melihat kumpulan my post
    * Menambahkan Hall of Shame

## Daftar fitur atau modul beserta Pembagian Pengerjaan
1. Login, Regist, Logout (Munifah Nurfadhilah)
2. Timeline Post-an Forum (Upvote, Komen untuk Logged In User dan hanya menampilkan untuk not Logged In User) (Andi Ayuna Rymang)
3. Profile Logged In User (Dafi Nafidz Radhiyya)
4. Create Forum dan Post untuk Logged In User (Andi Muhamad Dzaky Raihan)
5. Hall of shame (Tm Revanza Narendra Pradipta)

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
1. Menambahkan *dependency* `http` ke proyek, dependency ini digunakan untuk bertukar data melalui *HTTP request*, seperti **GET**, **POST**, **PUT**, dan lain-lain.
2. Membuat model sesuai dengan respons dari data yang berasal dari *web service* tersebut.
3. Membuat *http request ke web service* menggunakan *dependency* `http`.
4. Mengkonversikan objek yang didapatkan dari *web service* ke model yang telah kita buat di langkah kedua.
5. Menampilkan data yang telah dikonversi ke aplikasi dengan `FutureBuilder`.
