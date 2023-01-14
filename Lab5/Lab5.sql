/* 1.	�������� ���, ������� � ���� ������ ������ ���� �����������, ���������� � ����� ������ � �Magee�.*/

SELECT FIRST_NAME, LAST_NAME, START_DATE
FROM S_EMP
WHERE DEPT_ID = (SELECT DEPT_ID FROM S_EMP WHERE LAST_NAME = 'Magee');

/* 2.	�������� �����, ���, ������� � ��� ������������ ��� ���� �����������, ���������� ����� ������� ���� �������.*/

SELECT ID, FIRST_NAME, LAST_NAME
FROM S_EMP
WHERE SALARY > (SELECT AVG(SALARY) FROM S_EMP);

/* 3.	�������� �������, ����� ������ � ��������� ���� �����������, ����������� � �������� 1 ��� 2.*/

SELECT LAST_NAME, DEPT_ID, TITLE
FROM S_EMP
WHERE DEPT_ID IN (SELECT ID FROM S_DEPT WHERE REGION_ID IN (1, 2));

/* 4.	�������� ������� � ���������� ����� ���� ����������� �LaDoris Ngao�.*/

SELECT LAST_NAME, SALARY
FROM S_EMP
WHERE MANAGER_ID = (SELECT ID FROM S_EMP WHERE LAST_NAME = 'Ngao' AND FIRST_NAME = 'LaDoris');

/* 5.	�������� �����, ��� � ������� ������� ����������, ������� �������� ���������� ����� ���� ������� � �������� � ����� ������ � ����� �����������, ������� �������� �������� ����� �t�.*/

SELECT ID, LAST_NAME
FROM S_EMP
WHERE SALARY > (SELECT AVG(SALARY) FROM S_EMP)
  AND DEPT_ID IN (SELECT DEPT_ID FROM S_EMP WHERE FIRST_NAME LIKE '%t%');

/* 6.	�������� ����� � ������������ �������, � ����� ��������� ������� � ������� ��������� ������������� ��� ���� ��������,
    ������� ����������� � �������� ������� ��� ���� �������� �������������� �������� �Nguyen�.*/
    
SELECT CUSTOMER.ID            AS CUSTOMER_ID,
       CUSTOMER.NAME          AS CUSTOMER_NAME,
       CUSTOMER.CREDIT_RATING AS CREDIT_RATING,
       EMP.LAST_NAME          AS EMPLOYER_NAME
FROM S_CUSTOMER CUSTOMER
     JOIN S_EMP EMP ON CUSTOMER.SALES_REP_ID = EMP.ID
WHERE CUSTOMER.REGION_ID = (SELECT ID FROM S_REGION WHERE NAME = 'Central America')
   OR CUSTOMER.SALES_REP_ID = (SELECT ID FROM S_EMP WHERE LAST_NAME = 'Nguyen');

/* 7.	�������� ������������ � ������� �������� ������� ������, ������� �� ���� �� ��� ������� � �������� 1992 �.*/

SELECT DISTINCT PRODUCT.NAME, PRODUCT.SHORT_DESC
FROM S_ITEM ITEM
     JOIN S_PRODUCT PRODUCT ON ITEM.PRODUCT_ID = PRODUCT.ID
WHERE ITEM.ORD_ID IN (SELECT ID FROM S_ORD WHERE TO_CHAR(DATE_ORDERED, 'YYYY-MM') != '1992-09');

/* 8.	�������� ������������ � ��������� ������� ���� ��������, ���� �������� �������������� �������� �Andre Dumas�.
    ��� ���������� � ������?*/
    
SELECT NAME, CREDIT_RATING
FROM S_CUSTOMER
WHERE SALES_REP_ID = (SELECT ID FROM S_EMP WHERE FIRST_NAME = 'Andre' AND LAST_NAME = 'Dumas');

/* 9.	�������� ������� ������� ��������� ������������� � �������� 1 � 2, ������������ �� �������� � �������� ����� ������� ������� �������.*/

SELECT EMP.LAST_NAME AS EMPLOYEE_NAME,
       CUSTOMER.NAME AS CUSTOMER_NAME,
       ORD.TOTAL     AS TOTAL_SUM
FROM S_EMP EMP
     JOIN S_CUSTOMER CUSTOMER ON CUSTOMER.SALES_REP_ID = EMP.ID
     JOIN S_ORD ORD ON ORD.CUSTOMER_ID = CUSTOMER.ID
WHERE EMP.DEPT_ID IN (SELECT ID FROM S_DEPT WHERE REGION_ID IN (1, 2));

/* 10.	���������� ������������ �����, ������� ������� ������������ ���������� ������� (��������������, ��� ����� ����� ����). */

SELECT CUSTOMER.NAME AS CUSTOMER_NAME,
       CUSTOMER.ID   AS CUSTOMER_ID
FROM S_CUSTOMER CUSTOMER
     JOIN S_ORD ORD ON ORD.CUSTOMER_ID = CUSTOMER.ID
GROUP BY CUSTOMER.NAME, CUSTOMER.ID
HAVING COUNT(CUSTOMER.ID) = (SELECT COUNT
                             FROM (SELECT DISTINCT COUNT(CUSTOMER_ID) AS COUNT FROM S_ORD GROUP BY CUSTOMER_ID ORDER BY COUNT DESC)
                             WHERE ROWNUM = 1);
