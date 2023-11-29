# MODUL 11 SUBQUERY
Praktikum 6 - Amelia Vega - 225150600111021 - DBDSQL Kelas A

(Tugas di Gmail)
#
#
Sebelum menjawab pertanyaan dari soal, praktikan mendownload database_universitas.sql lalu melakukan running pada sekitar 34 ribu baris insert yang tersimpan. Kemudian, praktikan menerapkan sintax use untuk sampel_university.

    ```
    create database sampel_university;
    use sampel_university;

    create table classroom
    (building		varchar(15),
    room_number		varchar(7),
    capacity		numeric(4,0),
    primary key (building, room_number)
    );

    create table department
	  (dept_name		varchar(20), 
	  building		varchar(15), 
	  budget		        numeric(12,2) check (budget > 0),
	  primary key (dept_name)
	  );

    create table course
	  (course_id		varchar(8), 
	  title			varchar(50), 
	  dept_name		varchar(20),
	  credits		numeric(2,0) check (credits > 0),
	  primary key (course_id),
	  foreign key (dept_name) references department(dept_name)
    on delete set null
	  );

    create table instructor
	  (ID			varchar(5), 
    name			varchar(20) not null, 
	  dept_name		varchar(20), 
	  salary			numeric(8,2) check (salary > 29000),
	  primary key (ID),
	  foreign key (dept_name) references department(dept_name)
	  on delete set null
	  );

    create table section
	  (course_id		varchar(8), 
    sec_id			varchar(8),
	  semester		varchar(6)
 	  check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	  year			numeric(4,0) check (year > 1701 and year < 2100), 
	  building		varchar(15),
	  room_number		varchar(7),
	  time_slot_id		varchar(4),
	  primary key (course_id, sec_id, semester, year),
	  foreign key (course_id) references course(course_id)
	  on delete cascade,
	  foreign key (building, room_number) references classroom(building, room_number)
	  on delete set null
	  );

    dan sintax seterusnya ......
   ![Screenshot 2023-11-29 174808](https://github.com/AmeliaVegaa/Amelia-Vega_Praktikum-DBDSQL_Tugas-8/assets/133181467/652210d7-ba72-4145-9b25-b5da1e0ba404)

#
#
### TUGAS LATIHAN
Buatlah subquery untuk:
1. Menampilkan instructor yang belum pernah mengajar!
   ```
   SELECT ID, name
   FROM instructor
   WHERE ID NOT IN (SELECT DISTINCT ID FROM teaches);
   ````
   ![Screenshot 2023-11-29 173705](https://github.com/AmeliaVegaa/Amelia-Vega_Praktikum-DBDSQL_Tugas-8/assets/133181467/b1561867-d69d-4ef3-b0b8-f4b0dbb7a953)

2. Menampilkan course yang pernah diajar setidaknya 2 instructor!
    ```
    SELECT course_id, title
    FROM course
    WHERE course_id IN (
      SELECT course_id
      FROM teaches
      GROUP BY course_id
      HAVING COUNT(DISTINCT ID) >= 2
    );
    ```
    ![Screenshot 2023-11-29 173755](https://github.com/AmeliaVegaa/Amelia-Vega_Praktikum-DBDSQL_Tugas-8/assets/133181467/76ccc416-21ca-4537-98b8-582b168cf94b)

3. Menampilkan student yang paling banyak mendapat nilai A!
    ```
    SELECT s.ID, s.name, COUNT(t.grade) AS total_A_grades
    FROM student s
    JOIN takes t ON s.ID = t.ID
    WHERE t.grade = 'A'
    GROUP BY s.ID, s.name
    ORDER BY total_A_grades DESC
    LIMIT 1;
    ```
    ![Screenshot 2023-11-29 173855](https://github.com/AmeliaVegaa/Amelia-Vega_Praktikum-DBDSQL_Tugas-8/assets/133181467/f10ca780-cca5-467a-ad42-3dc3ad1085bd)
