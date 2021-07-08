import Foundation

func getTime() -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let formattedDate = format.string(from: date)
    return formattedDate
}

func MovieLog(message: String, file: String = #file, function: String = #function, line: Int = #line) {
    print("\(getTime()) \(file.components(separatedBy: ".")[0]):\(function):(\(line)) - \(message)")
}

class Something {
    func addTwoNumber(a: Int, b: Int) -> Int {
        let result = a + b
        MovieLog(message: "The result of \(a) + \(b) is: \(result)")
        return result
    }
}

let something = Something()
something.addTwoNumber(a: 2, b: 3)


