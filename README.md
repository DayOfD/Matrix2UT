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

```csv:
"func_name","temp_in","in","in","in_exp","return","out_exp","result"
"","","","","glA","","glA",""
"foo","int","1","2","3","0","6",""
...
```


LICENCE
=======
This software is released under CC0: http://creativecommons.org/publicdomain/zero/1.0/
