//
//  parsingTest.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/01.
//

import Foundation

struct getDatas: Codable {
    let data: data?
    let massage: String?
    let statusCode: Int?
}

struct data: Codable {
    let productDetailDto: productDetailDto?
    let userShowResponse: userShowResponse?
    
    enum CodingKeys: String, CodingKey {
        case productDetailDto
        case userShowResponse
    }
}

struct productDetailDto: Codable {
    let certificationFailedReason : String?
    let certificationStatus : String?
    let description : String?
    let fileList: [fileList]?
    let id: Int?
    let name: String?
    let price: Int?
    let productGrade: getGrade?
    let salesStatus: String?
    let useStatus: getState?
}

struct fileList: Codable {
    let filePath: String?
    let fileType: String?
}

struct userShowResponse: Codable {
    let name: String?
    let phoneNumber: String?
}

enum getGrade: String, Codable {
    case HIGH = "A"
    case INTERMEDIATE_HIGH = "B"
    case INTERMEDIATE = "C"
    case INTERMEDIATE_LOW = "D"
    case LOW = "E"
    case NONE = ""
}

enum getState: String, Codable {
    case USED = "중고"
    case DISUSED = "미개봉"
}
