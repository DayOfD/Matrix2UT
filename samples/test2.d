import std.stdio;
import matrix2ut;

void main()
{
	class C
	{
		int hoge;
		C fuga;
		
		bool foo(int x)
		{
			fuga.hoge = x;
			return hoge + x > 5;
		}
		bool bar(int x)
		{
			fuga.hoge = hoge = x;
			return hoge + x > 5;
		}
	}
	
	auto a = new C;
	auto b = new C;
	a.fuga = b;
	b.fuga = a;
	
	import std.file, std.string;
	copy("test2.csv", "test2-testing.csv");
	mixin(csv2ut!"test2.csv");
	assert((cast(string)std.file.read("test2.csv")).chomp == (cast(string)std.file.read("test2-tested.csv")).chomp);
	remove("test2.csv");
	copy("test2-testing.csv", "test2.csv");
	remove("test2-testing.csv");
}
