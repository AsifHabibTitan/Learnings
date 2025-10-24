import UIKit

//protocol Student {
//    var name: String { get }
////    func getName() -> String
////    mutating func setName(name: String)
//    var age: Int { get }
//}
//
//class Stu : Student {
//
//    func getName() -> String {
//        return self.name
//    }
//    func setName(name: String)  {
//        self.name = name
//    }
//
//    init(name: String) {
//        self.name = name
//    }
//    var name: String = "4334"
//
//    var age = 44
//}
//
//var st = Stu(name : "Kyle")
//print(st.getName())
//st.setName(name: "Kilo")
//print(st.getName())
//
//
//// Delegate pattern
//
//class Manager {
//    var developer : Developer;
//    init( _developer : Developer ) {
//        developer = _developer
//        developer.manager = self
//    }
//    func addTwoNumbers(x: Int, y: Int) {
//        developer.addTwoNumbers(x, y)
//    }
//    func gotResult(_ r: Int) {
//        print("result for sum : \(r)")
//    }
//}
//
//class Developer {
//
//    var manager : Manager;
//    init() {
//
//    }
//    func addTwoNumbers(_ a: Int, _ b: Int) {
//        let result =  a + b
//        manager.gotResult(result)
//    }
//}
//
//let objManager = Manager(_developer: Developer())
//objManager.addTwoNumbers(x: 3, y: 33)

struct Person {
    var arr = [1,3,4]
    var n: Int
}
var p = Person(n: 4)
print(p)
