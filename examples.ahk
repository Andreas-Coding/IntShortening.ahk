#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input
SetWorkingDir, %A_ScriptDir%

;creating a shortener using standard one sign symbols
shortenerExample1 := new IntShortening(2, "k", "M", "B")
example(shortenerExample1, "shortenerExample1")


;creating a shortener using standard one sign symbols for amounts of data
shortenerExample1 := new IntShortening(2, "k", "M", "G")
example(shortenerExample1, "shortenerExample1")


;the shortening class could use any string for the ending
shortenerExample2 := new IntShortening(1, " thousand", " million", " billion")
example(shortenerExample2, "shortenerExample2")


return


/*
	test for various legal ints to show the posibilitys of this lib
*/
example(obj, exampleText){

	static testsnumbers := [0, 5, 27, 924, 1355, 12345]
	test := exampleText . "`nstatic numbers for testing:`n"
	for k, element in testsnumbers{
		test .= Format("`nMethod: {1:s}, Accuracy: {2:d}, Input: {3:d}, Out: {4:s}", "stdFloor(int)", obj.accuracy, element, obj.stdFloor(element))
		test .= Format("`nMethod: {1:s}, Accuracy: {2:d}, Input: {3:d}, Out: {4:s}", "stdRound(int)", obj.accuracy, element, obj.stdRound(element))
	}

	MsgBox, , % "IntShortener Class Test", % test
	MsgBox, , % "IntShortener Class Test Test", % DynExample(obj, 0, 999, exampleText)
	MsgBox, , % "IntShortener Class Test Test", % DynExample(obj, 1000, 999999, exampleText)
	MsgBox, , % "IntShortener Class Test Test", % DynExample(obj, 1000000, 999999999, exampleText)
	MsgBox, , % "IntShortener Class Test Test", % DynExample(obj, 1000000000, 2147483647, exampleText)

}


/*
	creates dynamically generated integers for random tests
*/
DynExample(obj, min, max, exampleText){
	test := exampleText . "`nTestrange: " . min . " <= x < " . max + 1 . "`n"
	if(max > 2147483647)
		correction := max - 2147483647

	Loop, 5 {
		if(correction){
			Random, num, 2147483647 - (max - min), 2147483647
			max += 2147483647
			min += 2147483647
		} else {
			Random, num, min, max
		}
		
		test .= Format("`nMethod: {1:s}, Accuracy: {2:d}, Input: {3:d}, Out: {4:s}", "stdFloor(int)", obj.accuracy, num, obj.stdFloor(num))
		test .= Format("`nMethod: {1:s}, Accuracy: {2:d}, Input: {3:d}, Out: {4:s}", "stdRound(int)", obj.accuracy, num, obj.stdRound(num))
	}
	return, test
}


#Include, IntShortening.ahk