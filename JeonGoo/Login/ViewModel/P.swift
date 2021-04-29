//
//  P.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/04/29.
//

import Foundation

struct P: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let price: String?
    let userStatus: String?
    let productGrade: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = ""
        case description = "description"
        case price = "price"
        case userStatus = "userStatus"
        case productGrade = "productGrade"
    }
}
