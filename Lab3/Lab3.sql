/* 1.	������� ������� � ��������: 
    1 �����, ���������� �������, ����� ������ � �������� ������ ��� ������� ����������.
    2 �����, ���������� �������, �������� ������ � �������� ������� ��� ���� �����������, ���������� ������������. */
    
SELECT EMP.LAST_NAME AS LAST_NAME, DEPT.ID AS DEPT_ID, DEPT.NAME AS DEPT_NAME
FROM S_EMP EMP
     JOIN S_DEPT DEPT ON EMP.DEPT_ID = DEPT.ID;

SELECT EMP.LAST_NAME AS LAST_NAME, DEPT.NAME AS DEPT_NAME, REGION.NAME AS REGION_NAME
FROM S_EMP EMP
     JOIN S_DEPT DEPT ON EMP.DEPT_ID = DEPT.ID
     JOIN S_REGION REGION ON DEPT.REGION_ID = REGION.ID
WHERE COMMISSION_PCT IS NOT NULL;

/* 2.	������� ������� � �������� ������� � �������� ������ ��� ���������� �� ������� �Smith�.*/

SELECT EMP.LAST_NAME, DEP.NAME AS DEP_NAME
FROM S_EMP EMP
     JOIN S_DEPT DEP ON EMP.DEPT_ID = DEP.ID
WHERE EMP.LAST_NAME = 'Smith';

/* 3.	������� ������� � �������� ������������ ������, ������ ������ � ���������� ���������� �� ���� �������� ������ ����� 106.*/

SELECT PRODUCT.NAME AS PRODUCT_NAME, PRODUCT.ID AS PRODUCT_ID, ITEM.QUANTITY AS ITEMS_QUANTITY
FROM S_PRODUCT PRODUCT
     JOIN S_ITEM ITEM ON PRODUCT.ID = ITEM.PRODUCT_ID
     JOIN S_ORD ORD ON ITEM.ORD_ID = ORD.ID
WHERE ORD.ID = 106;

/* 4.	��� ���� ���������� � ���� �� ������� �������� ����� ���������, ��� ������������ � ����� ������. ���� ���� ������ �� ����� �����, ��� ����� � ������������ ������ ���� �������� � ������. */

SELECT CUSTOMER.ID AS CUSTOMER_ID, CUSTOMER.NAME AS CUSTOMER_NAME, ORD.ID AS ORD_ID
FROM S_CUSTOMER CUSTOMER
     LEFT JOIN S_ORD ORD ON CUSTOMER.ID = ORD.CUSTOMER_ID;

/* 5. �������� ������� � ������ ���� ����������� ������ � ��������� � �������� �� ����������.*/

SELECT EMP.LAST_NAME AS EMPLOYER_NAME, EMP.ID AS EMPLOYER_ID, MAN.LAST_NAME AS MANAGER_NAME, MAN.ID AS MANAGER_ID
FROM S_EMP EMP
     JOIN S_EMP MAN ON EMP.MANAGER_ID = MAN.ID;

/* 6.	��� ������� ���������, ����� ����� ������ �������� ��������� 100 000, �������� ������������ ���������, ���������� �� ������, �� ����������.*/

SELECT CUSTOMER.NAME AS CUSTOMER_NAME, PRODUCT.NAME AS PRODUCT_NAME, ITEM.QUANTITY AS ITEM_QUANTITY
FROM S_ORD ORD
     JOIN S_CUSTOMER CUSTOMER ON ORD.CUSTOMER_ID = CUSTOMER.ID
     JOIN S_ITEM ITEM ON ITEM.ORD_ID = ORD.ID
     JOIN S_PRODUCT PRODUCT ON ITEM.PRODUCT_ID = PRODUCT.ID
WHERE ORD.TOTAL >= 100000;

/* 7.	�������� ������ ������� � �������� ���� �������� � ��������� ���������� ������� � ������ �������.*/

SELECT REGION.ID AS REGION_ID, REGION.NAME AS REGION_NAME, COUNT(DEPT.ID) AS DEPT_COUNT
FROM S_REGION REGION
     JOIN S_DEPT DEPT ON DEPT.REGION_ID = REGION.ID
GROUP BY REGION.ID, REGION.NAME;

/* 8.	�������� ������������ ������� ������� � ���������� ��������� �� �������.*/

SELECT CUSTOMER.NAME AS CUSTOMER_NAME, COUNT(ORD.ID) AS ORD_COUNT
FROM S_CUSTOMER CUSTOMER
     JOIN S_ORD ORD ON ORD.CUSTOMER_ID = CUSTOMER.ID
GROUP BY CUSTOMER.NAME;

/* 9.	��� ������� ���� ������, �����������, �� ������� ����, ��� ����, �������� �������� ����� ������ � ���������� ������� �� ����.*/

SELECT PRODUCT.NAME AS PRODUCT_NAME, COUNT(PRODUCT_ID) AS TIMES_ORDERED
FROM S_ITEM ITEM
     JOIN S_PRODUCT PRODUCT ON ITEM.PRODUCT_ID = PRODUCT.ID
GROUP BY PRODUCT.ID, PRODUCT.NAME
HAVING COUNT(PRODUCT_ID) >= 3
ORDER BY PRODUCT.ID;

/* 10.	��� ������� ������ � ����� ����������� ���������� ������� 100 ��� ����� �������� ����� ������ � ����� ���������� ���������� ������� � ���.
    (����, ��������, ����� ����� 99 �������� ����� �� ���� ����� � ���������� 30, � �� ������ � � ���������� 75, �� ����� ���������� ���������� ������� ����� 105).*/
    
SELECT ORD.ID AS ORD_ID, SUM(ITEM.QUANTITY) AS QUANTITY_SUM
FROM S_ORD ORD
     JOIN S_ITEM ITEM ON ITEM.ORD_ID = ORD.ID
GROUP BY ORD.ID
HAVING SUM(ITEM.QUANTITY) >= 100;
