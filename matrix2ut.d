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
