//
//  product.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/03.
//

import Foundation

struct productData: Codable {
    var interestCount: Int
    let interested: Bool
    let userShowResponse: userInfo
    let productDetailDto: productInfo
    
    private enum CodingKeys: String, CodingKey {
        case interestCount, userShowResponse, productDetailDto, interested
    }
}

struct userInfo: Codable {
    let name: String
    let phoneNumber: String
}

struct productInfo: Codable {
    let certificationFailedReason: String
    let certificationStatus: String
    var hitCount: Int
    let id: Int
    let name: String
    let description: String
    let price: Int
    let useStatus: String
    let productGrade: String
    let salesStatus: String
    
    private enum CodingKeys: String, CodingKey {
        case hitCount, id, name, description, price, useStatus, productGrade, salesStatus, certificationFailedReason,certificationStatus
    }
}

extension productData {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        interestCount = (try? values.decode(Int.self, forKey: .interestCount)) ?? -1
        userShowResponse = (try? values.decode(userInfo.self, forKey: .userShowResponse)) ?? userInfo.init(name: "Null", phoneNumber: "Null")
        productDetailDto = (try? values.decode(productInfo.self, forKey: .productDetailDto)) ?? productInfo.init(certificationFailedReason: "Null" ,certificationStatus: "Null" ,hitCount: 1, id: 1, name: "Null", description: "Null", price: 1, useStatus: "Null", productGrade: "Null", salesStatus: "Null")
        interested = (try? values.decode(Bool.self, forKey: .interested)) ?? false
    }
}

extension productInfo {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        certificationFailedReason = (try? values.decode(String.self, forKey: .certificationFailedReason)) ?? "Null"
        certificationStatus = (try? values.decode(String.self, forKey: .certificationStatus)) ?? "Null"
        hitCount = (try? values.decode(Int.self, forKey: .hitCount)) ?? -1
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        name = (try? values.decode(String.self, forKey: .name)) ?? "Null"
        description = (try? values.decode(String.self, forKey: .description)) ?? "Null"
        price = (try? values.decode(Int.self, forKey: .price)) ?? -1
        useStatus = (try? values.decode(String.self, forKey: .useStatus)) ?? "Null"
        productGrade = (try? values.decode(String.self, forKey: .productGrade)) ?? "Null"
        salesStatus = (try? values.decode(String.self, forKey: .salesStatus)) ?? "Null"
    }
}

func setGrade(value: String) -> String {
    switch value {
    case "HIGH":
        return "A등급"
    case "INTERMEDIATE_HIGH":
        return "B등급"
    case "INTERMEDIATE":
        return "C등급"
    case "INTERMEDIATE_LOW":
        return "D등급"
    case "LOW":
        return "E등급"
    case "NONE":
        return "NULL"
    case "REQUEST":
        return "검수중"
    case "FAILED":
        return "반려"
    default:
        return "Null"
    }
}

func setProductState(value: String) -> String {
    switch value {
    case "SOLD_OUT":
        return "판매완료"
    case "SALE":
        return "판매중"
    default:
        return "Null"
    }
}
