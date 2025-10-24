
import Foundation

func printAddress<T>(_ value: inout T, label: String) {
    withUnsafePointer(to: value) { ptr in
        debugPrint("\(label): \(ptr)")  // debugPrint flushes better in Playground
    }
}

struct MyStruct {
    var number: Int
}

var originalStruct = MyStruct(number: 10)
var copyStruct = originalStruct

printAddress(&originalStruct, label: "Original before copy")
printAddress(&copyStruct, label: "Copy before modification")

copyStruct.number = 20

printAddress(&originalStruct, label: "Original after copy modified")
printAddress(&copyStruct, label: "Copy after modification")
