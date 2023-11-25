# UNION AND SUBQUERY IN SQL
Praktikum 6 - Amelia Vega - 225150600111021 - DBDSQL Kelas A
#
#
Praktikan mendownload `code.sql` lalu menunggu proses insert hingga selesai. Kemudian, praktikan menggunakan sintaks `use` untuk mengquery schema `AKADEMIK`.

    ```
    create schema AKADEMIK;

    create table AKADEMIK.FAKULTAS
    (
        ID_FAKULTAS smallint primary key,
        FAKULTAS VARCHAR(45)
    );

    use akademik;
    ```
#
#
### LATIHAN 1
1. Lakukan perintah insert untuk menambahkan data pada table Mahasiswa.
   ```
   INSERT INTO akademik.mahasiswa valuesvalues ('225150600111021', 1, 211, 'NANA', 2022, '2003-03-01', 'Jakarta', 'W'), ('235150600111021', 2, 212, 'ANTO', 2023, '2005-10-02', 'Balikpapan', 'P');
   ````

2. Lakukan perintah DDL untuk membuat sebuah table baru Mahasiswa_Pindahan.
    ```
    CREATE TABLE AKADEMIK.MAHASISWA_PINDAHAN
    (
    NIM VARCHAR(15) NOT NULL PRIMARY KEY,
    ID_SELEKSI_MASUK SMALLINT,
    FOREIGN KEY (ID_SELEKSI_MASUK) REFERENCES AKADEMIK.SELEKSI_MASUK(ID_SELEKSI_MASUK),
    ID_PROGRAM_STUDI SMALLINT,
    FOREIGN KEY (ID_PROGRAM_STUDI) REFERENCES AKADEMIK.PROGRAM_STUDI(ID_PROGRAM_STUDI),
    NAMA VARCHAR(45),
    ANGKATAN SMALLINT,
    TGL_LAHIR DATE,
    KOTA_LAHIR VARCHAR(60),
    JENIS_KELAMIN CHAR(1) CHECK (JENIS_KELAMIN IN ('P','W'))
    ```

3. Lakukan perintah insert untuk menambahkan data pada table Mahasiswa_Pindahan.
    ```
    INSERT INTO AKADEMIK.MAHASISWA_PINDAHAN
    VALUES  ('225150600111022', 1 ,211,'AMEL', 2022,'2003-09-01','BOGOR','W'),
            ('225150600111023', 2 ,212,'LIA',2022,'2003-11-03','MEDAN','W'),
            ('225150600111024', 2 ,211,'VEGA', 2022,'2003-07-12','BERAU','W'),
            ('225150600111025', 2 ,211,'GAMELIAV',2022,'2003-12-29','SURABAYA','W');
    ```
4. Tampilkan NIM, NAMA, JENIS_KELAMIN, KOTA LAHIR dan ANGKATAN dari Mahasiswa yang memiliki Kota Lahir dengan inisial B dan dari Mahasiswa_Pindahan yang memiliki Nama dengan inisial D. Urutkan berdasarkan NIM.
    ```
    select mp.NIM, mp.NAMA, mp.JENIS_KELAMIN, mp.KOTA_LAHIR, mp.ANGKATAN
    from(
        select *
            from AKADEMIK.MAHASISWA_PINDAHAN mp1
            where substr(mp1.KOTA_LAHIR, 1, 1) = 'B'
        union
        select *
            from AKADEMIK.MAHASISWA_PINDAHAN mp2
            where substr(mp2.NAMA, 1, 1) = 'D'
    ) mp;
    ```
5. Tampilkan NIM, NAMA, JENIS_KELAMIN, KOTA LAHIR dan ANGKATAN dari Mahasiswa Angkatan 2015 dan dari Mahasiswa_Pindahan tetapi kecuali Mahasiswa_Pindahan yang memiliki Kota Lahir dengan inisial M urutkan berdasarkan NIM.
    ```
    select data.NIM, data.NAMA, data.JENIS_KELAMIN, data.KOTA_LAHIR, data.ANGKATAN
    from(
        select * from AKADEMIK.mahasiswa m1
            where m1.ANGKATAN = 2022
        union
        select *
        from(
            select * from AKADEMIK.MAHASISWA_PINDAHAN mpz
            except
            select * from AKADEMIK.MAHASISWA_PINDAHAN mp
                     where substr(mp.KOTA_LAHIR, 1, 1) = 'W'
        ) mp_tanpa_inisial_m
    ) data;
    ```
#
#
### LATIHAN 2
1.  Tampilkan NIM, Nama dan Angkatan dari Mahasiswa yang memiliki Kota Lahir yang sama dengan Mahasiswa Pindahan dengan nama AMEL.
    ```
    select m.NIM, m.NAMA, m.ANGKATAN from AKADEMIK.mahasiswa m, (
        select * from akademik.mahasiswa_pindahan mp where mp.NAMA like "%amel%"
    ) mp_budi
    where m.KOTA_LAHIR = mp_budi.KOTA_LAHIR;
    ```

2.  Tampilkan NIM, Nama dan Angkatan dari Mahasiswa yang memiliki Kota Lahir yang sama dengan seluruh Mahasiswa Pindahan.
    ```
    select m.NIM, m.NAMA, m.ANGKATAN, m.KOTA_LAHIR, "sama kota lahir dengan", mp.NAMA, mp.KOTA_LAHIR
    from AKADEMIK.mahasiswa m, (
        select * from AKADEMIK.mahasiswa_pindahan
    ) mp
    where m.KOTA_LAHIR = mp.KOTA_LAHIR;
    ```
