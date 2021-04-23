//
//  Date+Extension.swift
//  SwiftUISample03
//
//  Created by ParkJonghyun on 2020/09/23.
//

import UIKit

extension Date {
    func toString(format:String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
