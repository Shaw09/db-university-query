-- 1.Selezionare tutti gli studenti nati nel 1990 
SELECT * FROM students WHERE YEAR(date_of_birth) = 1990;

-- 2.Selezionare tutti i corsi che valgono più di 10 crediti
SELECT * FROM courses WHERE cfu > 10;

-- 3.Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM students WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 30;

-- 4.Selezionare tutti i corsi di laurea magistrale
SELECT * FROM degrees d WHERE `level` = 'magistrale';

SELECT DISTINCT `level` FROM degrees d 

-- 5.Da quanti dipartimenti è composta l’università?
SELECT COUNT(id)
FROM departments d
WHERE id IS NOT NULL;

-- 6.Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT COUNT(id) FROM teachers t WHERE phone IS NULL;

-- 7.Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(enrolment_date), COUNT(id)
FROM students s 
GROUP BY YEAR(enrolment_date)
ORDER BY enrolment_date;

-- 8.Calcolare la media dei voti di ogni appello d’esame
SELECT AVG(vote) exam_id
FROM exam_student es 
GROUP BY exam_id;

-- 9.Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT department_id COUNT(*)
FROM degrees d 
GROUP BY department_id;

-- 10.Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT *
FROM students s 
JOIN degrees d ON s.degree_id = d.id
WHERE d.name = 'Corso di Laurea in Economia';

-- 11.Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT deg.*
FROM degrees deg
JOIN departments dep
ON dep.id = deg.department_id
WHERE dep.name LIKE 'Dipartimento di Neuroscienze' AND deg.`level` LIKE 'Magistrale';

-- 12.Selezionare tutti i corsi in cui insegna Fulvio Amato
SELECT ct.*
FROM teachers t 
INNER JOIN course_teacher ct 
ON t.id = ct.teacher_id 
INNER JOIN courses c 
ON c.id = ct.course_id 
WHERE t.name = 'Fulvio' AND t.surname = 'Amato';

-- 13.Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT s.name, s.surname, d.name, d2.name
FROM students s 
INNER JOIN degrees d ON s.degree_id = d.id
INNER JOIN departments d2 ON d.department_id = d2.id;

-- BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT s.name, s.surname, COUNT(es.vote), c.name, c.id
FROM students s 
JOIN exam_student es ON s.id = es.student_id 
JOIN exams e ON es.exam_id = e.id 
JOIN courses c ON e.course_id = c.id 
GROUP BY s.id, c.id 
HAVING MAX(es.vote) >= 18
ORDER BY s.name, s.surname;