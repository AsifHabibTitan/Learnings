import UIKit
//
//struct Phone {
//    var number: Int
//}
//class PhoneClass {
//    var number: Int
//    init(number: Int) {
//        self.number = number
//    }
//}
//
//var ph1 = Phone(number: 2323232323)
//ph1.number = 7878787878
//var ph2 = ph1
//ph2.number = 5959595959
//
//print(ph1, ph2)

class Phone {
    var name: String
    init(name1: String) {
        self.name = name1
    }
}

class SmartPhone: Phone {
    
    // func playGame() {
    //     print("playing game")
    // }
    // init(name: String) {
    //     super.init(name: name)
    // }
}

let ph = Phone(name1: "nokia")
let smartPhone = SmartPhone(name1: "hkjh")
