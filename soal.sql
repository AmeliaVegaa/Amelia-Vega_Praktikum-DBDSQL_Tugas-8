use akademik;

# Latihan I
# Nomor 1
INSERT INTO akademik.mahasiswa valuesvalues ('225150600111021', 1, 211, 'NANA', 2022, '2003-03-01', 'Jakarta', 'W'), ('235150600111021', 2, 212, 'ANTO', 2023, '2005-10-02', 'Balikpapan', 'P');
# Nomor 2
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
);
# Nomor 3
INSERT INTO AKADEMIK.MAHASISWA_PINDAHAN
    VALUES  ('225150600111022', 1 ,211,'AMEL', 2022,'2003-09-01','BOGOR','W'),
            ('225150600111023', 2 ,212,'LIA',2022,'2003-11-03','MEDAN','W'),
            ('225150600111024', 2 ,211,'VEGA', 2022,'2003-07-12','BERAU','W'),
            ('225150600111025', 2 ,211,'GAMELIAV',2022,'2003-12-29','SURABAYA','W');
# Nomor 4
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
# Nomor 5
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



# LATIHAN II
# Nomor 1 - Subquery
select m.NIM, m.NAMA, m.ANGKATAN from AKADEMIK.mahasiswa m, (
        select * from akademik.mahasiswa_pindahan mp where mp.NAMA like "%amel%"
    ) mp_budi
where m.KOTA_LAHIR = mp_budi.KOTA_LAHIR;
# Nomor 2 - Subquery
select m.NIM, m.NAMA, m.ANGKATAN, m.KOTA_LAHIR, "sama kota lahir dengan", mp.NAMA, mp.KOTA_LAHIR
from AKADEMIK.mahasiswa m, (
    select * from AKADEMIK.mahasiswa_pindahan
) mp
where m.KOTA_LAHIR = mp.KOTA_LAHIR;
