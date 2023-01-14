/* 1.	�������� ���������� � ���������� ����� ����� ������ �� ������� S_ORD.*/

SELECT MAX(TOTAL) AS MAX, MIN(TOTAL) AS MIN
FROM S_ORD;

/* 2.	��������� ������ ��� ������ ����������� � ������������ ���������� ����� �� ���� ���������� � ���������� �������.*/

SELECT MIN(SALARY) AS MIN, MAX(SALARY) AS MAX, TITLE
FROM S_EMP
GROUP BY TITLE
ORDER BY TITLE;

/* 3.	���������� ���������� ���������� ��� ������ ���������� � ���.*/

SELECT COUNT(DISTINCT MANAGER_ID) AS MANAGER_COUNT
FROM S_EMP;

/* 4.	�������� ����� ������� ������ � ���������� ������� � ���. ������� � ����������� ������� ���������� �Number of Items�.*/

SELECT ORD_ID, COUNT(ORD_ID) AS ORD_COUNT
FROM S_ITEM
GROUP BY ORD_ID;

/* 5.	�������� ����� ������� ��������� � ���������� ����� ������ ������������������ �� ��� �����������.
    ��������� ������ � ����������� ���������� ������ ����� 1000. 
    ������������ ���������� �� ������� ���������� �����.*/

SELECT MANAGER_ID, MIN(SALARY) AS MIN_SALARY
FROM S_EMP
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY) <= 1000
ORDER BY MIN_SALARY;

/* 6.	�������� ������� ����� ����� ������� � ����� ������ ���������� ������.*/

SELECT MAX(SALARY) - MIN(SALARY) AS DIFF_SALARY
FROM S_EMP;

/* 7.	��� ������� ���� ������, �����������, �� ������� ����, ��� ����, �������� ����� ����� ������ � ���������� ������� �� ����.
    ������� � ����������� ������� �� ����� ���������� �Times Ordered�.
    ������������ ������ �� ������� ���������� �������.*/
    
SELECT PRODUCT_ID, COUNT(PRODUCT_ID) AS TIMES_ORDERED
FROM S_ITEM
GROUP BY PRODUCT_ID
HAVING COUNT(PRODUCT_ID) >= 3
ORDER BY PRODUCT_ID;

/* 8.	�������� ������ ������� ���� �������� � ��������� ���������� ������� � ������ �������.*/

SELECT REGION_ID, COUNT(ID) AS DEPT_COUNT
FROM S_DEPT
GROUP BY REGION_ID;

/* 9.	�������� ����� ������� ������� � ���������� ��������� �� �������.*/

SELECT CUSTOMER_ID, COUNT(ID) AS ORD_COUNT
FROM S_ORD
GROUP BY CUSTOMER_ID;

/* 10.	��������� ������������ � ��������� �������, ���������� ���������� �������� ����������� �� �����.
    ���: 1991 (���) --- 10 ������� 1992 (���) --- 5 ������� � �.�.*/
    
SELECT TO_CHAR(START_DATE, 'YYYY') || '(���) --- ' || COUNT(ID) || ' �������' AS MESSAGE
FROM S_EMP
GROUP BY TO_CHAR(START_DATE, 'YYYY');
