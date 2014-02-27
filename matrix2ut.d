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
	assert(csvdata.to2DArray() == [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]);
}



/*******************************************************************************
 * Write csv from strings of 2D array.
 */
string toCsvData(string[][] strarys)
{
	import std.array, std.algorithm, std.conv;
	auto app = appender!(string[][])();
	auto appCells = appender!(string[])();
	foreach (cols; strarys)
	{
		foreach (cell; cols)
		{
			appCells.put(text(`"`, cell.replace(`"`, `""`), `"`));
		}
		app.put(appCells.data.dup);
		appCells.shrinkTo(0);
	}
	return app.data.map!`a.join(",")`.join("\n");
}

unittest
{
	enum strarysdata = "a,b,c\nd,e,f\ng,h,i".to2DArray();
	static assert(strarysdata.toCsvData() == `"a","b","c"`"\n"`"d","e","f"`"\n"`"g","h","i"`);
	assert(strarysdata.toCsvData() == `"a","b","c"`"\n"`"d","e","f"`"\n"`"g","h","i"`);
}
