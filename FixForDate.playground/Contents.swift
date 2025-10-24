import UIKit
func convertDateFormatFromString(inputDate: String) -> Date? {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    print(olDateFormatter.timeZone.abbreviation())
    //olDateFormatter.timeZone = TimeZone(identifier:"GMT")
//    olDateFormatter.locale = Locale(identifier: "en_IN")
//    olDateFormatter.calendar = Calendar(identifier: .gregorian)
    if let formattedDate = olDateFormatter.date(from: inputDate) {
        return formattedDate
    }
    return nil
    
}
let testDates = [
    "2025-10-04 23:20:00",
    "2025-09-27 01:00:00",
    "2023-04-12 23:33:11",   // yyyy-MM-dd HH:mm:ss
    "2023/04/12 23:33:11",   // yyyy/MM/dd HH:mm:ss
    "2023.04.12 23:33:11",   // yyyy.MM.dd HH:mm:ss
    "12/04/2023 23:33:11",   // dd/MM/yyyy HH:mm:ss
    "12-04-2023 23:33:11",   // dd-MM-yyyy HH:mm:ss
    "04/12/2023 23:33:11",   // MM/dd/yyyy HH:mm:ss
    "12 Apr 2023 23:33:11",  // dd MMM yyyy HH:mm:ss
    "12 April 2023 23:33:11",// dd MMMM yyyy HH:mm:ss
    "Wed, 12 Apr 2023 23:33:11", // EEE, dd MMM yyyy HH:mm:ss
    "Wednesday, 12 April 2023 23:33:11", // EEEE, dd MMMM yyyy HH:mm:ss
    "2023-04-12",            // yyyy-MM-dd
    "12-04-2023",            // dd-MM-yyyy
    "04/12/23",              // MM/dd/yy
    "Apr 12, 2023",          // MMM dd, yyyy
    "April 12, 2023",        // MMMM dd, yyyy
    "11:33 PM",              // hh:mm a
    "23:33",                 // HH:mm
    "23:33:11",              // HH:mm:ss
    "20230412T233311"        // yyyyMMdd'T'HHmmss
]

var result = ""
for dateStr in testDates {
    if let date = convertDateFormatFromString(inputDate: dateStr) {
        result += "✅ Parsed \(dateStr) -> \(date) \n"
    } else {
        result += "❌ Failed to parse: \(dateStr) \n"
    }
}

print(result)



// MARK: NEW IMPLEMENTATION

func convertDateFormatFromStringToStandard(inputDate: String) -> Date? {
    // List of possible input formats
    let inputFormats = [
        "yyyy-MM-dd HH:mm:ss",
        "yyyy/MM/dd HH:mm:ss",
        "yyyy.MM.dd HH:mm:ss",
        "dd-MM-yyyy HH:mm:ss",
        "dd/MM/yyyy HH:mm:ss",
        "MM/dd/yyyy HH:mm:ss",
        "dd MMM yyyy HH:mm:ss",
        "dd MMMM yyyy HH:mm:ss",
        "EEE, dd MMM yyyy HH:mm:ss",
        "EEEE, dd MMMM yyyy HH:mm:ss",
        "yyyy-MM-dd",
        "dd-MM-yyyy",
        "MM/dd/yy",
        "MMM dd, yyyy",
        "MMMM dd, yyyy",
//        "hh:mm a",
//        "HH:mm",
//        "HH:mm:ss",
        "yyyyMMdd'T'HHmmss"
    ]
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    for format in inputFormats {
        formatter.dateFormat = format
        if let date = formatter.date(from: inputDate) {
            return date
        }
    }
    
    return nil
}


//result = ""
//for dateStr in testDates {
//    if let date = convertDateFormatFromStringToStandard(inputDate: dateStr) {
//        result += "✅ Parsed \(dateStr) -> \(date) \n"
//    } else {
//        result += "❌ Failed to parse: \(dateStr) \n"
//    }
//}

//print(result)
