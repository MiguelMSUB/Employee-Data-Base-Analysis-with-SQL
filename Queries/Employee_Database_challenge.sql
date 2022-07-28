-- Retrieve and create a new Retirement Titles table
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;



-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01') 
ORDER BY rt.emp_no, rt.to_date DESC;

-- Employee count by most recent job title
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Mentorship Eligibility just as Instructions required

SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM unique_titles

-- Aditional queries
-- Add departmet name
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	d.dept_name,
	ti.title
INTO mentorship_eligibilty_by_dept
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Employee count by Department name (Mentoring program)
SELECT COUNT(me.dept_name), me.dept_name
-- INTO Mentorship_by_dept
FROM mentorship_eligibilty_by_dept as me
GROUP BY me.dept_name
ORDER BY COUNT(me.dept_name) DESC;

-- Employee count by title (Mentoring program)
SELECT COUNT(me.title), me.title
-- INTO Mentorship_by_title
FROM mentorship_eligibilty_by_dept as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;