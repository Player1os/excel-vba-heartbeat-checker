' Write the current timestamp to the standard output.
Call WScript.StdOut.WriteLine(DateDiff("s", DateSerial(1970, 1, 1), Now()))
