module matrix2ut;

import std.algorithm: until;
import std.array:     Appender, array, empty;
import std.range:     drop, sequence, take, walkLength;

enum naturals = sequence!"a[0]+n"(1);
static assert(naturals[0] == 1);

/**
 * Parse header
 * Returns: hashtable which has kinds of headers
 *          and their indices
 */
auto parse(string[] header) pure @safe nothrow
{
    size_t[][string] ret;
    immutable headerList = [
        "func_name", "temp_arg", "in", "in_exp",
        "return", "out_exp", "result",
        ];
    auto idx = naturals;
    foreach(h; headerList)
    {
        auto tmp = header.until(h);
        auto len = tmp.walkLength;
        ret[h] = idx.take(len).array;
        idx.drop(len);
        header = header.drop(len);
    }
    return ret;
}

///
pure @safe nothrow unittest
{
    auto header = [
        "func_name",
        "temp_arg", "temp_arg",
        "in",
        "in_exp", "in_exp", "in_exp",
        "return",
        "out_exp", "out_exp",
        "result"];
    auto ret = header.parse();
    assert(ret["func_name"] = [0]);
    assert(ret["temp_arg"]  = [1, 2]);
    assert(ret["in"]        = [3]);
    assert(ret["in_exp"]    = [4, 5, 6]);
    assert(ret["return"]    = [7]);
    assert(ret["out_exp"]   = [8, 9]);
    assert(ret["result"]    = [10]);
}

string generateUnittest(in string[][] matrix) pure @safe
in
{
    assert(matrix.length >= 2);
}
body
{
    Appender!(string[]) utLines;

    string[] header = matrix[0];
    string[] exps   = matrix[1];

    size_t[string] headerParsed = header.parseHeader();
    size_t[] tempArgIndices = 

    matrix = matrix[2..$];

    foreach (line; matrix)
    {
        string funcName = line[0];
        // string result line[$-1];

        
    }

    return app.data.join();
}

/*******************************************************************************
 * Read to convert csv to strings of 2D array.
 */
string[][] to2DArray(string csvdata)
{
	import std.array, std.csv;
	auto app = appender!(string[][])();
	foreach (data; csvReader!string(csvdata))
	{
		app.put(array(data).dup);
	}
	return app.data;
}

unittest
{
	enum csvdata = "a,b,c\nd,e,f\ng,h,i";
	static assert(csvdata.to2DArray() == [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]);
}
