import UIKit

var greeting = "Hello, playground"

extension Int {
    mutating func square() {
        self = self * self
    }
}
var number = 2

number.square()


var step = 1

if (2, "s") < (2, "d") {
    print("d")
}

let (x, y , z) = (2, 4.1, false)
print(x)
print(y)

let f : String?
f = ""

var scr = Unit8.min
scr = scr &- 1
print(scr)
