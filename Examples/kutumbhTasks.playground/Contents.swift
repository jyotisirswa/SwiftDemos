import UIKit

var greeting = "Hello, playground"
print(greeting)


struct KutumbhOne {
    var kutumbObj1 : String?
}

var obj = KutumbhOne(kutumbObj1: "")

class KutumbhClass {
    private (set) var kutumbObj1 : String
    var objTwo = KutumbhClassTwo(obj: "")
    init (obj : String) {
        kutumbObj1 = obj
    }
    
    deinit {
        print(" KutumbhClass Deinit")
    }
}

class KutumbhClassTwo   {
    var kutumbObj1 : String?
    var objOne = KutumbhClass(obj: "")
    init (obj : String) {
        kutumbObj1 = obj
    }
    
    deinit{
        print(" KutumbhClassTwo Deinit")
    }
    
}
var objClass = KutumbhClass(obj: "Kutumbh Test")
print(objClass.kutumbObj1)

enum KutumbhEnum {
    case up(valueObj : Any)
    case down(valueObjTwo : Any)
}


var caseType : KutumbhEnum
caseType.up = "First"
caseType.do


class SingletongKutumbhClass {
    static let kutumbObj1 = SingletongKutumbhClass()
    
    private init () {
        
    }
    func accessObj () {
        print("")
    }
}



