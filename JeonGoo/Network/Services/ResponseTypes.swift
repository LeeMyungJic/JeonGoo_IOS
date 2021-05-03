//
//  ResponseTypes.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/03.
//

import Foundation

struct ResponseArrayType<T: Codable>: Codable {
        var status: Int?
        var message: String?
        var data: [T]?
}

struct ResponseType<T: Codable>: Codable {
        var status: Int?
        var message: String?
        var data: T?
}
