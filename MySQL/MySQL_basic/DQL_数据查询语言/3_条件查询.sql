#进阶2：条件查询
/*

语法：
	select 
		查询列表
	from
		表名
	where
		筛选条件;

# 执行顺序（与书写顺序不一致，但是逻辑是符合常识）：
# 1. form 子句，定位到表
# 2. where 子句，筛选条件
# 3. select子句，查询列表


分类：
	一、按条件表达式筛选
	
	简单条件运算符：> < = != <> >= <=
	
	二、按逻辑表达式筛选
	逻辑运算符：
	作用：用于连接条件表达式
		&& || !
		and or not
		
	and和&& ：两个条件都为true，结果为true，反之为false
	or或|| ： 只要有一个条件为true，结果为true，反之为false
	not或! ： 如果连接的条件本身为false，结果为true，反之为false
	
	三、模糊查询
		like
		between and
		in
		is null
	
*/
#一、按条件表达式筛选

#案例1：查询工资>12000的员工信息

SELECT 
	*
FROM 
	employees
WHERE 
	salary>12000;
	
	
#案例2：查询部门编号不等于90号的员工名和部门编号
SELECT 
	last_name,
	department_id
FROM
	employees
WHERE
	# <> <==> !=
	department_id<>90;
	# mySQL的包容和体谅，实在用了!=，也不会报错
	# department_id != 90;


#二、按逻辑表达式筛选

#案例1：查询工资z在10000到20000之间的员工名、工资以及奖金

# my try:
SELECT 
	last_name,
	salary, 
	commission_pct
FROM
	employees
WHERE
	# 10000~20000,默认包含边界
	salary>=10000 AND salary<=20000;
	
	

##案例2：查询部门编号不是在90到110之间，或者工资高于15000的员工信息

# my try:
SELECT 
	# 员工信息，理解为全部的信息
	*
FROM
	employees
WHERE
	# 98行（这个逻辑也是正确的！90~110，而不是90~100）
	department_id<90 OR department_id>110 OR salary>15000;
	# not (department_id>=90 and department_id<=110) or salary > 15000;
	
# answer
SELECT
	*
FROM
	employees
WHERE
	# 98行
	NOT(department_id>=90 AND  department_id<=110) OR salary>15000;
	
	

#三、模糊查询
/*
like

between and
in
is null|is not null

*/
#1. like
/*
特点：
①一般和通配符搭配使用
	通配符：
	% 任意多个字符,包含0个字符  (*在mySQL中已做他用)
	_ 任意单个字符
*/

#案例1：查询员工名中包含字符a的员工信息

SELECT 
	*
FROM
	employees
WHERE
	last_name LIKE '%a%';#不区分大小写 Atkinson Marlow
	

#案例2：查询员工名中第三个字符为n，第五个字符为l的员工名和工资

SELECT
	last_name,
	salary
FROM
	employees
WHERE
	last_name LIKE '__n_l%';


## 特殊字符 作为 普通字符使用：需要转义，可以用转义字符\
#案例3：查询员工名中第二个字符为_的员工名

SELECT
	last_name
FROM
	employees
WHERE
	last_name LIKE '_\_%';
	## mySQL也可以自己指定转义字符，使用escape关键字
	# last_name LIKE '_$_%' ESCAPE '$';

#2.between and
/*
①使用between and 可以提高语句的简洁度
②包含边界值
③两个边界值不要调换顺序

*/


#案例1：查询员工编号在100到120之间的员工信息

SELECT
	*
FROM
	employees
WHERE
	employee_id >= 100 AND employee_id<=120;
#----------------------
SELECT
	*
FROM
	employees
WHERE
	# employee_id BETWEEN 100 AND 120; # 100~120，书写的顺序从小到大,包含边界值
	# 查询员工编号不在100-120之间的员工信息
	employee_id < 100 OR employee_id > 120


#3. in
/*
含义：判断某字段的值是否属于 “in列表” 中的某一项
特点：
	①使用in提高语句简洁度
	②in列表的值类型必须一致或兼容
	③in列表中不支持通配符 （like模糊匹配，才支持通配符）
	
*/

#案例：查询员工的工种编号（job_id）是 IT_PROG、AD_VP、AD_PRES中的一个员工名和工种编号

SELECT
	last_name,
	job_id
FROM
	employees
WHERE
	job_id = 'IT_PROG' OR job_id = 'AD_VP' OR JOB_ID ='AD_PRES';
#------------------
SELECT
	last_name,
	job_id
FROM
	employees
WHERE
	job_id IN ('IT_PROG', 'AD_VP', 'AD_PRES'); # 列表中的值，需要一致或兼容（可以隐式转换）


#4、is null

/*
=或<>不能用于判断null值
is null或is not null 可以判断null值

*/

#案例1：查询没有奖金 (即commission_pct为null) 的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NULL;

#案例1：查询有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NOT NULL;

#----------以下为×
SELECT
	last_name,
	commission_pct
FROM
	employees

WHERE 
	salary IS 12000;
	# 上面报错，每个符号都有自己的定位
	# salary = 12000;
	
	
## 安全等于  <=>


#案例1：查询没有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct <=> NULL;
	
	
#案例2：查询工资为12000的员工信息
SELECT
	last_name,
	salary
FROM
	employees
WHERE 
	salary <=> 12000;
	

#is null  vs  <=>

IS NULL:仅仅可以判断NULL值，可读性较高，建议使用
<=>    :既可以判断NULL值，又可以判断普通的数值，可读性较低


## 练习题（第二题较难）

# 2.查询员工号为176的员工的姓名、部门号和年薪

# 年薪的计算：月薪*12*（1+奖金率）
SELECT
	CONCAT(first_name, ' ', last_name) 姓名,
	department_id 部门,
	# 奖金率为空的情况处理
	salary * 12 * (1 + IFNULL(commission_pct, 0)) 年薪
FROM
	employees
WHERE
	employee_id = 176;


# 查询表结构
DESC departments;
# 查询部门departments表中涉及到了哪些位置编号？（有一个陷阱：需要去重）
SELECT
	DISTINCT location_id
	#location_id
FROM
	departments;

## 经典面试题
# 问：select * from employees;
# 和 select * from employees where commission_pct like '%%' and last_name like '%%';
# 结果是否一样？并说明原因

# 不一样，commission_pct有空值，like无法匹配null



















