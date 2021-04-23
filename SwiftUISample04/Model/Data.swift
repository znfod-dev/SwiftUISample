//
//  Data.swift
//  SwiftUISample01
//
//  Created by ParkJonghyun on 2020/09/17.
//
import UIKit
import SwiftUI

let playerDataList: [PlayerData] =  readPlist("Players")

func readPlist(_ filename:String) -> [PlayerData] {
    var list = Array<PlayerData>()
    guard let path = Bundle.main.path(forResource: filename, ofType: "plist") else {
        return list
    }
    guard let array = NSArray(contentsOfFile: path) else { return list }
    for obj in array {
        let dictionary = obj as! Dictionary<String, Any>
        list.append(PlayerData(dictionary: dictionary))
    }
    return list
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class DateStore {
    static func StringToDate(str: String) -> Date {
        let format = DateFormatter()
        format.dateFormat = "YYYYMMdd"
        guard let date = format.date(from: str) else {
            return Date()
        }
        return date
    }
    static func getAge(birth:Date) -> Int {
        let components = Calendar.current.dateComponents([.year], from: birth, to: Date())
        return components.year ?? 0
    }
}

struct Screen {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}
