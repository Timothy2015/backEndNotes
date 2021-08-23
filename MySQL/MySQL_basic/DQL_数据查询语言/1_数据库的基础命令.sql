### --------数据库基础命令------------###

##【 操作“数据库”】

# 查看已有数据库
SHOW DATABASES;

# 使用/进入某个数据库
USE myemployees;
# 显示所在的库
SELECT DATABASE();

# 新建一个数据库
CREATE DATABASE test2;

# 删除一个数据库
DROP DATABASE test2;


##【 操作“表格”】

# 进入某个数据库
# use myemployees;
USE test;

# 查看当前数据库中的所有表单
SHOW TABLES;

# 如果stuinfo存在则删除
DROP TABLE IF EXISTS `stuinfo`;

# 新建一个stuinfo表格
CREATE TABLE `stuinfo` (
`id` INT,
`name` VARCHAR(20)
)

# 查看stuinfo的字段定义
DESC stuinfo;





