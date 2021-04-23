//
//  Player.swift
//  SwiftUISample01
//
//  Created by ParkJonghyun on 2020/09/17.
//

import UIKit
import SwiftUI

struct PlayerData: Identifiable {
    var id = UUID()
    var name: String
    var birth: Date
    var age: Int
    var uniform: String
    var position: String
    var style: String
    var images:[Image]
    var imageSizes:[CGSize]
    
    init(dictionary:Dictionary<String, Any>) {
        self.name = dictionary["name"] as? String ?? ""
        self.birth = DateStore.StringToDate(str: dictionary["birth"] as? String ?? "20000101")
        self.age = DateStore.getAge(birth: birth)
        self.uniform = dictionary["uniform"] as? String ?? ""
        self.position = dictionary["position"] as? String ?? ""
        self.style = dictionary["style"] as? String ?? ""
        let array = dictionary["images"] as? Array<String> ?? [""]
        self.images = array.compactMap({ return Image($0) })
        self.imageSizes = array.compactMap( {
            let uiImage = UIImage(named: $0)
            return uiImage?.size
        })
    }
    
}
