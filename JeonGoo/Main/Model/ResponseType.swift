import Foundation

struct ResponseArrayType<T: Codable>: Codable {
        var status: Int?
        var success: Bool?
        var message: String?
        var data: [T]?
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
