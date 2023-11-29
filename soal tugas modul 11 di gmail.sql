# TUGAS LATIHAN
  
# Nomor 1
SELECT ID, name
   FROM instructor
   WHERE ID NOT IN (SELECT DISTINCT ID FROM teaches);

# Nomor 2
SELECT course_id, title
    FROM course
    WHERE course_id IN (
      SELECT course_id
      FROM teaches
      GROUP BY course_id
      HAVING COUNT(DISTINCT ID) >= 2
    );

# Nomor 3
SELECT s.ID, s.name, COUNT(t.grade) AS total_A_grades
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.grade = 'A'
GROUP BY s.ID, s.name
ORDER BY total_A_grades DESC
LIMIT 1;
