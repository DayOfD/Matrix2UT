Matrix2UT
=========

Matrix2UT is a unittesting framework for D programming language.
It automatically generates unittests from the given input file in the form of the matrix (tabular).
It is easy to verify its results and to modify the set of unittest for more correctness.

How to use
==========
Let us consider the situation as follows.
We want to verify the correctness of the function `foo`.
It takes one template argument and two runtime arguments.
It may read or modify one global variable `glA`.
And we have a list to be tested.
We prepare the following CSV file which includes the list of the arguments for unittest.

```csv:sample.csv
"func_name","temp_in","in","in","in_exp","return","out_exp","result"
"","","","","glA","","glA",""
"foo","int","1","2","3","0","6",""
...
```

First two lines are the header for the unittest.
The first line denotes function properties to be tested.
`func_name`, `temp_in`, `in` and `in_exp` mean the inputs of the function or the global variables which may be modified by the function for unittest.

| property | `func_name` | `temp_in` | `in` | `in_exp` |
|----------|-------------|-----------|------|----------|
| meaning | function name | template argument| runtime argument | global variable |

`return`, `out_exp` and `result` mean the expected return value of the function,
the value of global variable after calling the function, and the unittest result respectively
(`result` will be overwritten after unittest).

The second line denotes the names of global variables for `in_exp` and `out_exp`.

To test `foo`, please import `matrix2ut` and call `csv2ut` for the input CSV file as follows
(we assume sample.d and sample.csv is in the same directory).

```d:sample.d
import matrix2ut; // To generate test cases

int foo(T)(int a, int b) { /* definition of foo */ }

unittest
{
    int glA;
    int glB;
    mixin(csv2ut!"sample.csv"); // generate tests!
}
```

`csv2ut` automatically generates all test cases in `sample.csv`.
After that, you can test `foo` as usual.

```sh:
$ rdmd -unittest -main sample.d
```

After running unittest, `csv2ut` writes the result to the column named `result` in `sample.csv`.
If all returned values are same as expected, you will see `OK` in the column `result`.
Otherwise you will see `NG` and the reason why the unittest failed.


Have fun!

Known Issue
===========
- Valuable arguments are not supported

LICENCE
=======
This software is released under CC0: http://creativecommons.org/publicdomain/zero/1.0/
