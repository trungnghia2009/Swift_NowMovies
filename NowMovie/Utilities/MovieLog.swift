//
//  MovieLog.swift
//  NowMovie
//
//  Created by NghiaTran on 07/07/2021.
//  Copyright © 2021 trungnghia. All rights reserved.
//

import Foundation

class MovieLog {
    
    static func info(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print("\(Date.getCurrentTime()) \(String.getLatestFileName(path: file)):\(function):(\(line)):INFO - \(message)")
    }
    
    static func error(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print("\(Date.getCurrentTime()) \(file.components(separatedBy: ".")[0]):\(function):(\(line)):ERROR - \(message)")
    }
    
    static func debug(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print("\(Date.getCurrentTime()) \(file.components(separatedBy: ".")[0]):\(function):(\(line)):DEBUG - \(message)")
    }
}

extension Date {
    static func getCurrentTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let formattedDate = format.string(from: Date())
        return formattedDate
    }
}

extension String {
    static func getLatestFileName(path: String) -> String {
        let arrayString = path.components(separatedBy: "/")
        return arrayString.last?.components(separatedBy: ".")[0] ?? "ErrorFileName"
    }
}
