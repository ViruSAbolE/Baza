/*1	�������� ����� ���������� �����, ��� ������� � ��������� � �������, ���������� �����, ���������� �� 15 % � ����������� �� ������ */
  
  SELECT 
  e.ID, 
  e.LAST_NAME || ' (' || e.TITLE || ')', 
  e.SALARY, 
  Round(e.SALARY*1.15, 0) 
FROM S_EMP e;

  /* 2	�������� ��� ������������ ����������, ���������� ����� �sport�, ��� ����������� �� �������� */
SELECT c.ID,c.NAME
  FROM S_CUSTOMER c
  WHERE UPPER(c.NAME) lIKE '%SPORT%';

/* 3	��������� ����������, ��������� ������� S_PRODUCT
1)	1)	����������� � ���������� ������� ��� ������, �������� ������� ���������� � �Pro�
2)	2)	�������� �������� � ������� �������� ���� ���������, � �������� ������� ���������� ����� �ski�, ��� ����������� �� ��������.*/

  SELECT p.ID, p.NAME 
    FROM S_PRODUCT p
    WHERE p.NAME LIKE 'Pro%'
    ORDER BY p.NAME ASC;

SELECT p.ID, p.NAME, p.SHORT_DESC
  FROM S_PRODUCT p
  WHERE UPPER(p.NAME) LIKE '%SKI%';

/*4	��������� ��������� ��������, ��������� �������� S_CUSTOMER
1)	�������� ������ ��� ������ ��������, ������ � ���������� �������� ���� ����-��������, ������� ��������� ������������� ��� ������� 11. ��������� ������
2)	2)	�������� ������� �������� �������� ��������� Company, Company ID, Rating. ��������� ������ ��� ��� */

  SELECT c.ID, c.NAME, c.PHONE, c.CREDIT_RATING
    FROM S_CUSTOMER c
    WHERE c.SALES_REP_ID=11;

SELECT c.ID AS "Company ID", c.NAME AS "Company",  c.PHONE, c.CREDIT_RATING AS "Rating"
    FROM S_CUSTOMER c
    WHERE c.SALES_REP_ID=11;

/*   5	 ��������� ��������� ���������� � �������� S_EMP
1)	�������� ��������� �������
2)	�������� ������ ����, ������� � ������� ������� ��� ����������� ������� 10 � 50. ������������ ������ �� �������� � ���������� �������. ���������� ��� � �������� � �������� ������� �Employees�.
3)	�������� ��� ������������ � ���� ������ ������ ���� �����������, ������� ����� 14 ��� 1990 ���� � 26 ��� 1991 ����. ���������� ������� ������������ �� �������� ��� ������ ������.
4)	�������� ������ ������� � ���������� ����� ���� ����������� ������� 31, 42, � 50, �������� ��������� ������� �� ����� � ��������� �� 1000 �� 2500. �������� ������� �Employee Name�, � ������� ���������� ����� � �MONTHLY SALARY�.*/


  SELECT e.ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS "Employees", e.DEPT_ID
    FROM S_EMP e
  WHERE e.DEPT_ID=10 OR e.DEPT_ID=50
  ORDER BY e.LAST_NAME ASC;

  SELECT e.ID, e.USERID, e.START_DATE
    FROM S_EMP e
    WHERE e.START_DATE BETWEEN TO_DATE('14.05.1990', 'dd.mm.yyyy') AND TO_DATE('26.05.1991', 'dd.mm.yyyy')
  ORDER BY e.START_DATE DESC;

  SELECT e.LAST_NAME AS "Employee Name", e.SALARY AS "MONTHLY SALARY"
  FROM S_EMP e
    WHERE e.DEPT_ID IN (31, 42, 50) AND e.SALARY NOT BETWEEN 1000 AND 2500;

  /*    6	��������� ������ ��� ��������� ��������� ���������� �� ������� ����������: <��� ����������> ������������ <��������> � �����, �� ������ <��������� ��������>.  ��������: ALLEN ������������ 1100 � �����, �� ������ 3300.    */

    SELECT e.FIRST_NAME || ' зарабатывает ' || e.SALARY || ' в месяц, но желает ' || e.SALARY*3 AS "MESSAGE"
      FROM S_EMP e;

    /*    7 ��� ������� ���������� �������� �������, ��������� ���������� ������� �� ��� ������ ������ �� ���������� �������, ���� ������, ����� �� ��� ����� �� ������. ���������� ������������ �� ���������� ������������ �������. ���������� ������� ��������� �� ������      */

SELECT e.LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, E.START_DATE), 0) AS MONTHS_COUNT, TO_CHAR(e.START_DATE, 'DAY')
  FROM S_EMP e
  ORDER BY MONTHS_COUNT;


  /* 8	��� ������� ���������� �������� �������, ���� ����� � ���� ���������� ��������, ������� ���������� �� ������ ����������� ����� ����� ������� ������. ������ ���� �� ������: �����.�����.���, �������� 12.01.2012.*/
  
    SELECT e.LAST_NAME, TO_CHAR(e.START_DATE, 'dd.mm.yyyy'), TO_CHAR(NEXT_DAY(ADD_MONTHS(E.START_DATE, 6), 2), 'dd.mm.yyyy')
      FROM S_EMP e