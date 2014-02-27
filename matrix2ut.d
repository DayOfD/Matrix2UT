module matrix2ut;

import std.array:     Appender;

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
        string result line[$-1];

        
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
