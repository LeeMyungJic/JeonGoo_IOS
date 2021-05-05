//
//  User.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/05.
//

import Foundation

struct User: Codable {
    let addressDto: adress
    let email: String
    let gender: String
    let id: Int
    let name: String
    let password: String
    let phoneNumber: String
    
    struct adress: Codable {
        let city: String
        let detailed: String
    }
}
