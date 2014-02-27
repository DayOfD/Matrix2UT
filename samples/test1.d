import std.stdio;
import matrix2ut;

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
	mixin(csv2ut!"test1.csv");
}
