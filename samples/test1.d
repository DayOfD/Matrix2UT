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
	
	import std.file, std.string;
	copy("test1.csv", "test1-testing.csv");
	mixin(csv2ut!"test1.csv");
	assert((cast(string)std.file.read("test1.csv")).chomp == (cast(string)std.file.read("test1-tested.csv")).chomp);
	remove("test1.csv");
	copy("test1-testing.csv", "test1.csv");
	remove("test1-testing.csv");
}
