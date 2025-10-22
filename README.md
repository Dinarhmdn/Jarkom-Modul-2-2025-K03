# Jarkom-Modul-2-2025-K03


1. Di tepi Beleriand yang porak-poranda, Eonwe merentangkan tiga jalur: Barat untuk Earendil dan Elwing, Timur untuk Círdan, Elrond, Maglor, serta pelabuhan DMZ bagi Sirion, Tirion, Valmar, Lindon, Vingilot. Tetapkan alamat dan default gateway tiap tokoh sesuai glosarium yang sudah diberikan.

<img width="799" height="683" alt="Screenshot 2025-10-22 at 23 15 14" src="https://github.com/user-attachments/assets/6e9543cd-112f-4a60-8597-5275b40c3b4d" />


2. Angin dari luar mulai berhembus ketika Eonwe membuka jalan ke awan NAT. Pastikan jalur WAN di router aktif dan NAT meneruskan trafik keluar bagi seluruh alamat internal sehingga host di dalam dapat mencapai layanan di luar menggunakan IP address.

# EONWE (Router)#
 ``` 
 auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.65.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.65.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.65.4.1
    netmask 255.255.255.0
```

# Earendil 
```
auto eth0
iface eth0 inet static
    address 10.65.1.2
    netmask 255.255.255.0
    gateway 10.65.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Elwing
```
auto eth0
iface eth0 inet static
    address 10.65.1.3
    netmask 255.255.255.0
    gateway 10.65.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Cirdan
```
auto eth0
iface eth0 inet static
    address 10.65.2.2
    netmask 255.255.255.0
    gateway 10.65.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Elrond
```
auto eth0
iface eth0 inet static
    address 10.65.2.3
    netmask 255.255.255.0
    gateway 10.65.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Maglor 
```
auto eth0
iface eth0 inet static
    address 10.65.2.4
    netmask 255.255.255.0
    gateway 10.65.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Sirion
```
auto eth0
iface eth0 inet static
    address 10.65.4.5
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Tirion
```
auto eth0
iface eth0 inet static
    address 10.65.4.2
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Valmar
```
auto eth0
iface eth0 inet static
    address 10.65.4.3
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Lindon
```
auto eth0
iface eth0 inet static
    address 10.65.4.4
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
# Vingilot
```
auto eth0
iface eth0 inet static
    address 10.65.4.5
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

3. Kabar dari Barat menyapa Timur. Pastikan kelima klien dapat saling berkomunikasi lintas jalur (routing internal via Eonwe berfungsi), lalu pastikan setiap host non-router menambahkan resolver 192.168.122.1 saat interfacenya aktif agar akses paket dari internet tersedia sejak awal.


4. Para penjaga nama naik ke menara, di Tirion (ns1/master) bangun zona <xxxx>.com sebagai authoritative dengan SOA yang menunjuk ke ns1.<xxxx>.com dan catatan NS untuk ns1.<xxxx>.com dan ns2.<xxxx>.com. Buat A record untuk ns1.<xxxx>.com dan ns2.<xxxx>.com yang mengarah ke alamat Tirion dan Valmar sesuai glosarium, serta A record apex <xxxx>.com yang mengarah ke alamat Sirion (front door), aktifkan notify dan allow-transfer ke Valmar, set forwarders ke 192.168.122.1. Di Valmar (ns2/slave) tarik zona <xxxx>.com dari Tirion dan pastikan menjawab authoritative. pada seluruh host non-router ubah urutan resolver menjadi IP dari ns1.<xxxx>.com → ns2.<xxxx>.com → 192.168.122.1. Verifikasi query ke apex dan hostname layanan dalam zona dijawab melalui ns1/ns2.

![WhatsApp Image 2025-10-22 at 23 22 11](https://github.com/user-attachments/assets/97d92554-9889-485b-a777-0556afcfc758)

# Tirion
```
apt update
apt install bind9 -y

nano /etc/bind/named.conf.local
zone "K03.com" {
  type master;
  notify yes;
  also-notify { 10.65.4.3; };
  allow-transfer { 10.65.4.3; };
  file "/etc/bind/K03.com";
  };

zone "4.65.10.in-addr.arpa" {
  type master;
  notify yes;
  also-notify { 10.65.4.3; };
  allow-transfer { 10.65.4.3; };
  file "/etc/bind/4.65.10.in-addr.arpa";
  };

nano /etc/bind/K03.com
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     ns1.K03.com. root.K03.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

@       IN      NS      ns1.K04.com.
@       IN      NS      ns2.K03.com.
@       IN      A       10.65.4.5
ns1     IN      A       10.65.4.2
ns2     IN      A       10.89.3.3


nano /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";

        dnssec-validation no;

        forwarders { 192.168.122.1;};
        allow-query { any; };
        auth-nxdomain no;
        listen-on-v6 { any; };
};

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
```

# Valmar
```
apt update
apt install bind9 -y

nano /etc/bind/named.conf.local
zone "K03.com" {
  type slave;
  masters { 10.65.4.2; };
  file "/etc/bind/K03.com";
};

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
```
# Elwing (Contoh salah satu)
```
cat <<EOF > /etc/resolv.conf
nameserver 10.65.4.2
nameserver 10.65.4.3
nameserver 192.168.122.1
EOF
```

5. “Nama memberi arah,” kata Eonwe. Namai semua tokoh (hostname) sesuai glosarium, eonwe, earendil, elwing, cirdan, elrond, maglor, sirion, tirion, valmar, lindon, vingilot, dan verifikasi bahwa setiap host mengenali dan menggunakan hostname tersebut secara system-wide. Buat setiap domain untuk masing masing node sesuai dengan namanya (contoh: eru.<xxxx>.com) dan assign IP masing-masing juga. Lakukan pengecualian untuk node yang bertanggung jawab atas ns1 dan ns2

![WhatsApp Image 2025-10-22 at 23 22 12](https://github.com/user-attachments/assets/6d6baf92-32f8-44e2-b440-bd8a09c7253d)

# Tirion
```
nano /etc/bind/K03.com
eonwe     IN      A       192.168.122.247
earendil  IN      A       10.65.1.2
elwing    IN      A       10.65.1.3
cirdan    IN      A       10.65.2.2
elrond    IN      A       10.65.2.3
maglor    IN      A       10.65.2.4
sirion    IN      A       10.65.4.5
lindon    IN      A       10.65.4.4
vingilot  IN      A       10.65.4.5

service bind9 restart
```

6. Lonceng Valmar berdentang mengikuti irama Tirion. Pastikan zone transfer berjalan, Pastikan Valmar (ns2) telah menerima salinan zona terbaru dari Tirion (ns1). Nilai serial SOA di keduanya harus sama

# Elwing (Selain Server)
```
dig @10.65.4.2 ns2.K03.com SOA
dig @10.65.4.2 ns1.K03.com SOA
```

7. Peta kota dan pelabuhan dilukis. Sirion sebagai gerbang, Lindon sebagai web statis, Vingilot sebagai web dinamis. Tambahkan pada zona <xxxx>.com A record untuk sirion.<xxxx>.com (IP Sirion), lindon.<xxxx>.com (IP Lindon), dan vingilot.<xxxx>.com (IP Vingilot). Tetapkan CNAME :
www.<xxxx>.com → sirion.<xxxx>.com, 
static.<xxxx>.com → lindon.<xxxx>.com, dan 
app.<xxxx>.com → vingilot.<xxxx>.com. 
Verifikasi dari dua klien berbeda bahwa seluruh hostname tersebut ter-resolve ke tujuan yang benar dan konsisten.

# Tirion
```
nano /etc/bind/K03.com
www     IN  CNAME sirion.K03.com.
static  IN  CNAME lindon.K03.com.
app     IN  CNAME vingilot.K03.com.
```

8. Setiap jejak harus bisa diikuti. Di Tirion (ns1) deklarasikan satu reverse zone untuk segmen DMZ tempat Sirion, Lindon, Vingilot berada. Di Valmar (ns2) tarik reverse zone tersebut sebagai slave, isi PTR untuk ketiga hostname itu agar pencarian balik IP address mengembalikan hostname yang benar, lalu pastikan query reverse untuk alamat Sirion, Lindon, Vingilot dijawab authoritative.

11. Lampion Lindon dinyalakan. Jalankan web statis pada hostname static.<xxxx>.com dan buka folder arsip /annals/ dengan autoindex (directory listing) sehingga isinya dapat ditelusuri. Akses harus dilakukan melalui hostname, bukan IP.

12. Vingilot mengisahkan cerita dinamis. Jalankan web dinamis (PHP-FPM) pada hostname app.<xxxx>.com dengan beranda dan halaman about, serta terapkan rewrite sehingga /about berfungsi tanpa akhiran .php. Akses harus dilakukan melalui hostname.

13. Di muara sungai, Sirion berdiri sebagai reverse proxy. Terapkan path-based routing: /static → Lindon dan /app → Vingilot, sambil meneruskan header Host dan X-Real-IP ke backend. Pastikan Sirion menerima www.<xxxx>.com (kanonik) dan sirion.<xxxx>.com, dan bahwa konten pada /static dan /app di-serve melalui backend yang tepat.

14. Ada kamar kecil di balik gerbang yakni /admin. Lindungi path tersebut di Sirion menggunakan Basic Auth, akses tanpa kredensial harus ditolak dan akses dengan kredensial yang benar harus diizinkan.

15. “Panggil aku dengan nama,” ujar Sirion kepada mereka yang datang hanya menyebut angka. Kanonisasikan endpoint, akses melalui IP address Sirion maupun sirion.<xxxx>.com harus redirect 301 ke www.<xxxx>.com sebagai hostname kanonik.

16. Di Vingilot, catatan kedatangan harus jujur. Pastikan access log aplikasi di Vingilot mencatat IP address klien asli saat lalu lintas melewati Sirion (bukan IP Sirion).
 
17. Pelabuhan diuji gelombang kecil, salah satu klien yakni Elrond menjadi penguji dan menggunakan ApacheBench (ab) untuk membombardir http://www.<xxxx>.com/app/ dan http://www.<xxxx>.com/static/ melalui hostname kanonik. Untuk setiap endpoint lakukan 500 request dengan concurrency 10, dan rangkum hasil dalam tabel ringkas.

18. Badai mengubah garis pantai. Ubah A record lindon.<xxxx>.com ke alamat baru (ubah IP paling belakangnya saja agar mudah), naikkan SOA serial di Tirion (ns1) dan pastikan Valmar (ns2) tersinkron, karena static.<xxxx>.com adalah CNAME → lindon.<xxxx>.com, seluruh akses ke static.<xxxx>.com mengikuti alamat baru, tetapkan TTL = 30 detik untuk record yang relevan dan verifikasi tiga momen yakni sebelum perubahan (mengembalikan alamat lama), sesaat setelah perubahan namun sebelum TTL kedaluwarsa (masih alamat lama karena cache), dan setelah TTL kedaluwarsa (beralih ke alamat baru).

19. Andaikata bumi bergetar dan semua tertidur sejenak, mereka harus bangkit sendiri. Pastikan layanan inti bind9 di ns1/ns2, nginx di Sirion/Lindon, dan PHP-FPM di Vingilot autostart saat reboot, lalu verifikasi layanan kembali menjawab sesuai fungsinya.

20. Sang musuh memiliki banyak nama. Tambahkan melkor.<xxxx>.com sebagai record TXT berisi “Morgoth (Melkor)” dan tambahkan morgoth.<xxxx>.com sebagai CNAME → melkor.<xxxx>.com, verifikasi query TXT terhadap melkor dan bahwa query ke morgoth mengikuti aliasnya.

21. Pelabuhan diperluas bagi para pelaut. Tambahkan havens.<xxxx>.com sebagai CNAME → www.<xxxx>.com, lalu akses layanan melalui hostname tersebut dari dua klien berbeda untuk memastikan resolusi dan rute aplikasi berfungsi.

22. Kisah ditutup di beranda Sirion. Sediakan halaman depan bertajuk “War of Wrath: Lindon bertahan” yang memuat tautan ke /app dan /static. Pastikan seluruh klien membuka beranda dan menelusuri kedua tautan tersebut menggunakan hostname (mis. www.<xxxx>.com), bukan IP address.




   
