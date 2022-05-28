CREATE TABLE person(
       pname VARCHAR2(30),
       psex CHAR(2),
       pbirthday DATE,
       pdept VARCHAR2(30),
       paddress VARCHAR2(30)
)
ALTER TABLE person ADD(pemail VARCHAR2(25));
ALTER TABLE person DROP COLUMN pemail;
CREATE VIEW person_view
       AS
       SELECT *FROM person;
CREATE INDEX pname_index ON person(pname);

ALTER TABLE person ADD(id VARCHAR2(25));
CREATE SEQUENCE person_sequence
       START WITH 1
       INCREMENT BY 1
       NOCYCLE
       ORDER
       NOCACHE;
INSERT INTO person(id,pname,psex,pbirthday,pdept,paddress)
VALUES(person_sequence.nextval,'Yzh','男',to_date('20020316','yyyymmdd'),'东北石油大学','大庆');
SELECT * FROM person;

CREATE TABLE emptest AS SELECT * FROM emp;
CREATE TABLE depttest AS SELECT * FROM dept;
SELECT empno,ename,sal FROM emptest
       ORDER BY sal ASC;
      
SELECT deptno,MAX(sal) FROM emptest
       WHERE job='MANAGER'
       GROUP BY deptno;
       
SELECT job AS 名称,MIN(sal) AS 最低工资,MAX(sal) AS 最高工资，wm_concat(ename) AS 姓名 FROM emptest
       GROUP BY job;


SELECT d.*,e.num  FROM depttest d
       LEFT JOIN
       (SELECT count(ename) AS num,DEPTNO FROM emptest GROUP BY deptno) e
       ON d.deptno=e.deptno;
       
//SELECT a.deptno,a.dname,a.loc,(SELECT count(ename) FROM emptest b WHERE b.deptno=a.deptno GROUP BY b.deptno) FROM depttest 
       LEFT JOIN
       (SELECT count(ename),DEPTNO FROM emptest GROUP BY deptno) e
       ON depttest.deptno=e.deptno; 


SELECT d.dname, e.num FROM depttest d
       LEFT OUTER JOIN
       (SELECT COUNT(ename) AS num,DEPTNO FROM emptest GROUP BY deptno) e
       ON d.deptno=e.deptno;

UPDATE emptest SET sal=(
       SELECT AVG(sal) FROM emptest)
       WHERE empno=7900;
       
SELECT empno,ename,job,mgr,hiredate,(
case WHEN sal>2000 THEN sal+sal*0.1
     WHEN sal<2000 THEN sal+sal*0.15
     ELSE sal
     END) AS sal,comm,deptno FROM emptest2;

SELECT * FROM depttest
       WHERE NOT EXISTS(
           SELECT *FROM emptest WHERE emptest.deptno=depttest.deptno
       );

SELECT * FROM emptest
    WHERE NOT EXISTS(
        SELECT * FROM depttest WHERE deptno=emptest.deptno
        AND loc='NEW YORK'
    );
    
DELETE FROM emptest2
    WHERE EXISTS(
        SELECT * FROM depttest WHERE deptno=emptest2.deptno
        AND loc='NEW YORK'
    );

CREATE TABLE emptest2 AS SELECT * FROM emptest;
SELECT * FROM emptest2;
