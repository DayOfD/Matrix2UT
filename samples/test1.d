import std.stdio;
//import matrix2ut;

void main()
{
	int glA;
	int glB;
	int glC;
	int foo(T,U)(T a, U b, int c)
	{
		glC += glA+glB;
		glA = a+b;
		glB = b*c;
		return a+b+c;
	}
	int bar(T,U)(T a, U b, int c)
	{
		glC -= glA+glB;
		glA = a+b;
		glB = b*c;
		return a+b+c;
	}
	
	glA = 0;
	glB = 0;
	auto ret = foo!(int,int)(1,2,3);
	assert(glA == 3);
	assert(glB == 6);
	assert(glC == 0);
	
	glA = 1;
	glB = 1;
	ret = foo!(int,int)(1,2,3);
	assert(glA == 3);
	assert(glB == 6);
	assert(glC == 2);
	
	glA = 1;
	glB = 1;
	ret = foo!(int,int)(1,2,3);
	assert(glA == 3);
	assert(glB == 6);
	assert(glC == 4);
	
	glA = 1;
	glB = 1;
	ret = bar!(int,int)(1,2,3);
	assert(glA == 3);
	assert(glB == 6);
	assert(glC == 6);
	
	
}
