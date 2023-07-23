import UIKit
 
class Student{
    private var name : String
    var rollno : Int
    public var age: Int
    init(name: String, rollno: Int, age: Int){
        self.name = name
        self.rollno = rollno
        self.age = age
    }
    func getMarks() -> Int{
        return 233
    }
    func getMarks(sub: String) -> String {
        return "marks of a subject"
    }
    func getName()-> String {
        return self.name
    }
    
}

class ArtsStudent : Student {
    override init(name: String, rollno: Int, age: Int){
        super.init(name: name, rollno: rollno, age: age)
        print("called the child class' constructor")
    }
    override func getMarks() -> Int {
        return 444
    }
    
}


let st1 = Student(name: "AA", rollno: 11, age: 23)
let st2 = ArtsStudent(name: "BB", rollno: 22, age: 24)

print(st1.getMarks())
print(st2.getMarks())
print(st2.getMarks(sub: "somestr"))
print(st1.getMarks(sub: "somestr"))

//print(st1.name)  // can't access name as it is private
//print(st2.name)

print(st1.getName())
print(st2.getName())

print(st1.age)
print(st2.age)


@propertyWrapper
struct TwelveOrLess {
    private var number: Int
    var wrappedValue : Int {
        get {
            return number
        }
        set{
            number = min(12, number)
        }
    }
}

//class NewClass {
//    @TwelveOrLess
//    var height: Int = number
//
////    init(height: Int) {
////        self.height = height
////    }
//    func getHeight () -> Int {
//        return height
//    }
//}

//
//var h = NewClass()
//print(h.getHeight())


// variadic parameter functions

func mean(_ numbers: Int...) -> Double{
    if numbers.count == 0 {
        return 0
    }
       
    var sum = 0
    for num in numbers {
        sum += num
    }
    return Double(sum/numbers.count)
}
print(mean(2,3,4,5,2,3,4,5))

//var a: Double = 1
//var b: Int = 2
//print(Double(a/b))

let arr = [1,4,5,6,7]

func addOne(n: Int) -> Int {
    return n + 1
}
arr.map(addOne)

arr.map({$0 + 1})

func makeIncrementer(amount: Int) -> () -> Int {
    var total = 0
    func incrementer() -> Int {
        total += amount
        return total
    }
    return incrementer
}

var increment = makeIncrementer(amount: 3)
increment()
increment()
increment()


var closuresArray : [()-> ()] = []

func appendingClosuresFunc(closure: @escaping () -> ()) {
    closuresArray.append(closure)
}

//enum onOfSwitch {
//    case on
//    case off
//    mutating func toggle() {
//        switch self {
//        case .off:
//            self = .on
//        case .on:
//            self = .off
//        }
//    }
//}
//
//var sw = onOfSwitch.on
//sw.toggle()
//print(sw)
//sw.toggle()
//print(sw)
//sw.toggle()
//print(sw)
//sw.toggle()
//print(sw)


struct Stack {
    public var st = [Int]()
    mutating func push(_ n:Int){
        print("function called")
        st.append(n)
    }
    mutating func pop() -> Int? {
        if !st.isEmpty {
            return st.removeLast()
        }
        return nil
    }
    
}

var st = Stack()
st.push 
st.push(43)
print(st.st)
st.pop()
print(st.st)

