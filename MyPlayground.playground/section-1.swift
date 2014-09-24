// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var firstInteger = 0
var secondInteger = 29
var thirdInteger = -1000858
var x = 5
var a = 1, y = 2, z = 3
var b = 5
var p = 1, d = 2, q = 3
var discountAtDepartmentStore = 0.3
var explicitInt:Int = 3

var discountOnShoesAtStore = 0.3
var priceOfShoes:Double = 33
var priceAfterDiscount = priceOfShoes * (1 - discountOnShoesAtStore)
var downPayment = 10.5
priceAfterDiscount -= downPayment
var 😜 = 1.234
var 😥 = 2.345
var w = 😜 * 😥

typealias WholeNumber = Int

var r:WholeNumber

var largNumber = 1_000_000_000_000
var weirdNumber = 1_0_0_0_0

str = "Hello world"
var st1 = str + " today"
str.uppercaseString
st1.capitalizedString

//var char = 'a'
//var char:Character = "aa"
var char:Character = "a"

var stringFromValue = "\(😜)"
var intFromString = stringFromValue.toInt()
var doubleFromString = Double((stringFromValue as NSString).doubleValue)
