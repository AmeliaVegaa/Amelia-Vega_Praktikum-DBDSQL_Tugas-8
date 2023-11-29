create schema AKADEMIK;

use AKADEMIK;

create table AKADEMIK.FAKULTAS (
	ID_FAKULTAS smallint primary key,
	FAKULTAS VARCHAR(45)
)

create table AKADEMIK.JURUSAN (
	ID_JURUSAN smallint not null primary key,
	ID_FAKULTAS smallint,
	JURUSAN VARCHAR(45),
	foreign key (ID_FAKULTAS) references AKADEMIK.FAKULTAS(ID_FAKULTAS)
)

create table AKADEMIK.STRATA (
	ID_STRATA smallint not null primary key,
	SINGKAT VARCHAR(10),
	STRATA VARCHAR(45)
)

create table AKADEMIK.PROGRAM_STUDI (
	ID_PROGRAM_STUDI smallint not null primary key,
	ID_STRATA smallint,
	ID_JURUSAN smallint,
	PROGRAM_STUDI VARCHAR(60),
	foreign key (ID_STRATA) references AKADEMIK.STRATA(ID_STRATA),
	foreign key (ID_JURUSAN) references AKADEMIK.JURUSAN(ID_JURUSAN)
)

create table AKADEMIK.SELEKSI_MASUK (
	ID_SELEKSI_MASUK smallint not null primary key,
	SINGKAT VARCHAR(12),
	SELEKSI_MASUK VARCHAR(60)
)

create table AKADEMIK.MAHASISWA (
	NIM VARCHAR(15) not null primary key,
	ID_SELEKSI_MASUK smallint,
	ID_PROGRAM_STUDI smallint,
	NAMA VARCHAR(45),
	ANGKATAN smallint,
	TGL_LAHIR DATE,
	KOTA_LAHIR VARCHAR(60),
	JENIS_KELAMIN CHAR(1),
	foreign key (ID_SELEKSI_MASUK) references AKADEMIK.SELEKSI_MASUK(ID_SELEKSI_MASUK),
	foreign key (ID_PROGRAM_STUDI) references AKADEMIK.PROGRAM_STUDI(ID_PROGRAM_STUDI)
)

insert into FAKULTAS(ID_FAKULTAS, FAKULTAS) values (1, 'Ekonomi & Bisnis'), (2, 'Ilmu Komputer');
insert into JURUSAN(ID_JURUSAN, ID_FAKULTAS, JURUSAN) values (21, 2, 'Informatika'), (22, 2, 'Sistem Informasi'), (23, 2, 'Teknik Komputer');
insert into STRATA(ID_STRATA, SINGKAT, STRATA) values (1, 'D1', 'Diploma'), (2, 'S1', 'Sarjana'), (3, 'S2', 'Magister');
insert into PROGRAM_STUDI(ID_PROGRAM_STUDI, ID_STRATA, ID_JURUSAN, PROGRAM_STUDI) values (211, 2, 21, 'Teknik Informatika'), (212, 2, 21, 'Teknik Komputer'), (219, 3, 21, 'Magister Ilmu Komputer');
insert into SELEKSI_MASUK(ID_SELEKSI_MASUK, SINGKAT, SELEKSI_MASUK) values (1, 'SNMPTN', 'SELEKSI NASIONAL MAHASISWA PERGURUAN TINGGI NEGERI'), (2, 'SBMPTN', 'SELEKSI BERSAMA MAHASISWA PERGURUAN TINGGI NEGERI');
insert into MAHASISWA(NIM, ID_SELEKSI_MASUK, ID_PROGRAM_STUDI, NAMA, ANGKATAN, TGL_LAHIR, KOTA_LAHIR, JENIS_KELAMIN) values ('225150600111021', 1, 211, 'NANA', 2022, '2003-03-01', 'Jakarta', 'W'), ('235150600111021', 2, 212, 'ANTO', 2023, '2005-10-02', 'Balikpapan', 'P');
