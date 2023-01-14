/*1	Выведите номер сотрудника фирмы, его фамилию и должность в скобках, заработную плату, повышенную на 15 % и округленную до целого */
  
  SELECT 
  e.ID, 
  e.LAST_NAME || ' (' || e.TITLE || ')', 
  e.SALARY, 
  Round(e.SALARY*1.15, 0) 
FROM S_EMP e;

  /* 2	Выведите все наименования заказчиков, содержащие слово “sport”, вне зависимости от регистра */
SELECT c.ID,c.NAME
  FROM S_CUSTOMER c
  WHERE UPPER(c.NAME) lIKE '%SPORT%';

/* 3	Выполните упражнения, используя таблицу S_PRODUCT
1)	1)	Перечислите в алфавитном порядке все товары, названия которых начинаются с “Pro”
2)	2)	Выведите названия и краткие описания всех продуктов, в описании которых содержится слово “ski”, вне зависимости от регистра.*/

  SELECT p.ID, p.NAME 
    FROM S_PRODUCT p
    WHERE p.NAME LIKE 'Pro%'
    ORDER BY p.NAME ASC;

SELECT p.ID, p.NAME, p.SHORT_DESC
  FROM S_PRODUCT p
  WHERE UPPER(p.NAME) LIKE '%SKI%';

/*4	Выполните следующие действия, пользуясь таблицей S_CUSTOMER
1)	Создайте запрос для вывода названия, номера и кредитного рейтинга всех фирм-клиентов, имеющих торгового представителя под номером 11. Выполните запрос
2)	2)	Измените команду присвоив столбцам заголовки Company, Company ID, Rating. Выполните запрос еще раз */

  SELECT c.ID, c.NAME, c.PHONE, c.CREDIT_RATING
    FROM S_CUSTOMER c
    WHERE c.SALES_REP_ID=11;

SELECT c.ID AS "Company ID", c.NAME AS "Company",  c.PHONE, c.CREDIT_RATING AS "Rating"
    FROM S_CUSTOMER c
    WHERE c.SALES_REP_ID=11;

/*   5	 Выполните следующие упражнения с таблицей S_EMP
1)	Покажите структуру таблицы
2)	Получите список имен, фамилий и номеров отделов для сотрудников отделов 10 и 50. Отсортируйте список по фамилиям в алфавитном порядке. Объедините имя с фамилией и назовите столбец “Employees”.
3)	Выведете имя пользователя и дату начала работы всех сотрудников, нанятых между 14 мая 1990 года и 26 мая 1991 года. Результаты запроса отсортируйте по убыванию дат начала работы.
4)	Получите список фамилий и заработной платы всех сотрудников отделов 31, 42, и 50, месячный заработок которых не лежит в интервале от 1000 до 2500. Назовите столбец “Employee Name”, а столбец заработной платы – “MONTHLY SALARY”.*/


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

  /*    6	Составьте запрос для получения следующей информации по каждому сотруднику: <имя сотрудника> зарабатывает <зарплата> в месяц, но желает <утроенная зарплата>.  Например: ALLEN зарабатывает 1100 в месяц, но желает 3300.    */

    SELECT e.FIRST_NAME || ' Р·Р°СЂР°Р±Р°С‚С‹РІР°РµС‚ ' || e.SALARY || ' РІ РјРµСЃСЏС†, РЅРѕ Р¶РµР»Р°РµС‚ ' || e.SALARY*3 AS "MESSAGE"
      FROM S_EMP e;

    /*    7 Для каждого сотрудника выведите фамилию, вычислите количество месяцев со дня начала работы до настоящего времени, день недели, когда он был нанят на работу. Результаты отсортируйте по количеству отработанных месяцев. Количество месяцев округлите до целого      */

SELECT e.LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, E.START_DATE), 0) AS MONTHS_COUNT, TO_CHAR(e.START_DATE, 'DAY')
  FROM S_EMP e
  ORDER BY MONTHS_COUNT;


  /* 8	Для каждого сотрудника выведите фамилию, дату найма и дату пересмотра зарплаты, которая приходится на первый понедельник после шести месяцев работы. Формат даты на выводе: «день.месяц.год», например 12.01.2012.*/
  
    SELECT e.LAST_NAME, TO_CHAR(e.START_DATE, 'dd.mm.yyyy'), TO_CHAR(NEXT_DAY(ADD_MONTHS(E.START_DATE, 6), 2), 'dd.mm.yyyy')
      FROM S_EMP e