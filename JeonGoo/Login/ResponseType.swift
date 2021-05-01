//
//  ResponseArrayType.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/01.
//

import Foundation

struct ResponseArrayType<T: Codable>: Codable {
    var data: [T]?
    var message: String?
    var statusCode: Int?
}

struct ResponseType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var data: T?
}

struct Response: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
}
