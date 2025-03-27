/* 1. Show unique birth years from patients and order them by ascending. */
select distinct year(birth_date) as birth_year
from patients
order by birth_year;

/* 2. Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output. */
select first_name
from patients
group by first_name
having count(first_name) = 1;

/* 3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. */
select patient_id
	, first_name
from patients
where first_name LIKE 'S%s' and
	len(first_name) >= 6;

/* 4. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */
select p.patient_id
	, p.first_name
    , p.last_name
from patients p
join admissions a on a.patient_id=p.patient_id
where a.diagnosis = 'Dementia';

/* 5. Display every patient's first_name.
Order the list by the length of each name and then by alphabetically. */
select first_name 
from patients
order by len(first_name)
	, first_name;

/* 6. Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */
select
	sum(case when gender = 'M' then 1 else 0 end) as male_count
    , sum(case when gender = 'F' then 1 else 0 end) as female_count
from patients

/* 7. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name. */
select first_name
	, last_name
    , allergies
from patients
where allergies in ('Penicillin', 'Morphine')
order by allergies asc
	, first_name
    , last_name;

/* 8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
SELECT patient_id
  , diagnosis
FROM admissions
GROUP BY
  patient_id
  , diagnosis
HAVING COUNT(admission_date) > 1;

/* 9. Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending. */
select city
	, count(patient_id) as num_patients
from patients
group by city
order by num_patients desc
	, city asc;

/* 10. Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor" */
select first_name
	, last_name
    ,'Patient' as role
from patients

union all

select
	first_name
    , last_name
    ,'Doctor' as role
from doctors;

/* 11. Show all allergies ordered by popularity. Remove NULL values from query. */
-- a. view all patients with their allergy diagnosis
select patient_id
	, allergies
from patients;

-- b. count their total allergies
select patient_id
	, allergies
    , count(allergies)
from patients
group by allergies;

-- c. filter out null values
select allergies
    , count(allergies) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc

