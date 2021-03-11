
USE myemployees;

#1.	下面的语句是否可以执行成功  
SELECT last_name , job_id , salary AS sal
FROM employees; 

#2.下面的语句是否可以执行成功  
SELECT  *  FROM employees; 


#3.找出下面语句中的错误 （错误使用了中文的标点符号，下面已修正的代码）
SELECT employee_id , last_name,
salary * 12 AS "ANNUAL  SALARY"
FROM employees;

#4.显示表departments的结构，并查询其中的全部数据

DESC departments;
SELECT * FROM `departments`;

#5.显示出表employees中的全部job_id（不能重复）
SELECT DISTINCT job_id FROM employees;


##【重难点，第6题】
#6.显示出表employees的全部列，各个列之间用逗号连接，列头显示成OUT_PUT

# 含有错误的解法：
SELECT 
	CONCAT(
	`employee_id`,",",
	`first_name`,",",
	`last_name`,",",
	`email`,",",
	`phone_number`,",",
	`job_id`,",",
	`salary`,",",
	`commission_pct`,",",
	`manager_id`,",",
	`department_id`,",",
	`hiredate`)
	
	AS "OUT_PUT"
FROM 
	employees;

# 为什么部分结果全为null呢？
# 因为commsision_pct的部分值为null, 一旦有null, concat()的结果为null

# 能不能做到，当commssion_pct的值为null时，显示为0？

# 正确的解法：
SELECT
	IFNULL(commission_pct, 0) AS 奖金率
FROM 
	employees;

SELECT 
	IFNULL(commission_pct,0) AS 奖金率,
	commission_pct
FROM 
	employees;
#-------------------------------------------
SELECT 
	CONCAT(
	`employee_id`,",",
	`first_name`,",",
	`last_name`,",",
	`email`,",",
	`phone_number`,",",
	`job_id`,",",
	`salary`,",",
	IFNULL(`commission_pct`, 0),",",
	`manager_id`,",",
	`department_id`,",",
	`hiredate`)
	
	AS "OUT_PUT"
FROM 
	employees;
	
	








