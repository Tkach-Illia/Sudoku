extends Node

#Keyboard events
signal showKeyboard(number: int, coords: Array)
signal changeNumber(new_number: int, coords: Array)

#Main - Kayboard communacation
signal initCalcValidNumbers(pair: Array)
signal returnValidNumbers(valid_numbers: Array)
