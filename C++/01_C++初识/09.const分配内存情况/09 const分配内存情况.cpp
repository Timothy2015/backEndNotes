#define _CRT_SECURE_NO_WARNINGS
#include<iostream>
using namespace std;
#include <string>

//1、对const变量 取地址 ，会分配临时内存  
void test01()
{
	const int a = 10;
	int * p = (int *)&a;
}

//2、使用普通变量  初始化 const变量
void test02()
{
	int a = 10;
	const int b = a;

	int *p = (int *)&b;
	*p = 1000;

	cout << "b = " << b << endl;

}

//3、对于自定义数据类型 
struct Person
{
	string m_Name;
	int m_Age;
};
void test03()
{
	const Person p;
	//p.m_Age = 10;

	Person * pp = (Person *)&p;
	(*pp).m_Name = "Tom";
	pp->m_Age = 10;

	cout << "姓名： " << p.m_Name << " 年龄： " << p.m_Age << endl;
}


int main(){

	//test02();
	test03();
	system("pause");
	return EXIT_SUCCESS;
}