module matrix2ut;

import std.algorithm: map, until;
import std.array:     Appender, array, empty, join;
import std.conv:      to;
import std.string:    format;
import std.range:     drop, sequence, take, walkLength;

private:

enum naturals = sequence!"a[0]+n"(1);
static assert(naturals[0] == 1);

/**
 * Parse header
 * Returns: hashtable which has kinds of headers
 *          and their indices
 */
auto parse(in string[] header) pure @safe nothrow
{
    size_t[][string] ret;
    immutable headerList = [
        "func_name", "temp_in", "in", "in_exp",
        "return", "out_exp", "result",
        ];
    auto idx = naturals.map!"a-1";
    auto hd = header[];
    foreach(h; headerList)
    {
        auto tmp = hd.until!"a != b"(h);
        auto len = tmp.walkLength;
        ret[h] = idx.take(len).array;
        idx = idx.drop(len);
        hd = hd.drop(len);
    }
    assert(hd.empty);
    return ret;
}

///
pure @safe nothrow unittest
{
    auto header = [
        "func_name",
        "temp_in", "temp_in",
        "in",
        "in_exp", "in_exp", "in_exp",
        "return",
        "out_exp", "out_exp",
        "result"];
    auto ret = header.parse();
    assert(ret["func_name"] == [0]);
    assert(ret["temp_in"]   == [1, 2]);
    assert(ret["in"]        == [3]);
    assert(ret["in_exp"]    == [4, 5, 6]);
    assert(ret["return"]    == [7]);
    assert(ret["out_exp"]   == [8, 9]);
    assert(ret["result"]    == [10]);
}

pure @safe nothrow unittest
{
    auto header = ["func_name", "in", "return"];
    auto ret = header.parse();
    assert(ret["func_name"] == [0]);
    assert(ret["in"]        == [1]);
    assert(ret["return"]    == [2]);
}

string generateUnittest(in string[][] matrix) pure @safe
in
{
    assert(matrix.length >= 2);
}
body
{
    Appender!(string[]) utLines;

    utLines.put(q{import std.array;});
    utLines.put(q{Appender!(string[]) results;});

    const string[] header = matrix[0];
    const string[] exps   = matrix[1]; 

    size_t[][string] headerParsed = header.parse();
    size_t[] tempInIndices = headerParsed["temp_in"];
    size_t[] inIndices     = headerParsed["in"];
    size_t[] inExpIndices  = headerParsed["in_exp"];
    size_t   returnIndex   = headerParsed["return"][0];
    size_t[] outExpIndices = headerParsed["out_exp"];

    foreach (lineIndex, line; matrix[2..$])
    {
        string funcName = line[0];
        string lineIndexStr = lineIndex.to!string();

        foreach(inExpIndex; inExpIndices)
        {
            utLines.put(exps[inExpIndex] ~ "=" ~ line[inExpIndex] ~ ";");
        }

        Appender!(string[]) tempArgs;

        foreach(inIndex; tempInIndices)
        {
            tempArgs.put(header[inIndex]);
        }

        Appender!(string[]) funcArgs;

        foreach(inIndex; inIndices)
        {
            funcArgs.put(header[inIndex]);
        }

        if (tempArgs.data.length)
        {
            utLines.put(format("results.put(utAssert(`%s`,%s!(%s)(%s),%s));", funcName,
                                                                              funcName,
                                                                              tempArgs.data.join(","),
                                                                              funcArgs.data.join(","),
                                                                              line[returnIndex]));
        }
        else
        {
            utLines.put(format("results.put(utAssert(`%s`,%s(%s),%s));", funcName,
                                                                         funcName,
                                                                         funcArgs.data.join(","),
                                                                         line[returnIndex]));
        }

        foreach(outExpIndex; outExpIndices)
        {
            utLines.put("results.put(utAssert(`" ~ exps[outExpIndex] ~ "`," ~ exps[outExpIndex] ~ "," ~ line[outExpIndex] ~ "));");
        }

        utLines.put("reports[" ~ lineIndexStr ~ "][$-1]=results.join(\"\\n\");");

        utLines.put("if(reports[" ~ lineIndexStr ~ "][$-1].empty)reports[ ~ lineIndexStr ~ ][$-1]=\"OK\";");

        utLines.put("results.shrinkTo(0);");
    }

    return utLines.data.join();
}

unittest
{
    assert(generateUnittest([["func_name", "in", "return", "result"],
                             ["hoge",      "0",  "0",      ""]])
                            ==
                            "import std.array;"
                            "Appender!(string[]) results;"
                            "results.put(utAssert(`hoge`,hoge(0),0));"
                            "reports[0][$-1]=resutls.join(\"\\n\");"
                            "if(reports[0][$-1].empty)reports[0][$-1]=\"OK\";"
                            "results.shrinkTo(0);");
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


public:

string utAssert(T)(string name, T right, T left)
{
	return null;
}

string matrix2ut(string csvdata)
{
	return null;
}
