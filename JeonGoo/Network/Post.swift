import Foundation

// MARK: - Post
struct Post: Codable {
    let statusCode: Int?
    let message: String?
    let data: Int?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case message = "message"
        case data = "data"
    }
}

struct LoginData: Codable {
    let statusCode: Int
    let message: String
    let data: getData
    
    struct getData: Codable {
        let id: Int
        let token: String
    }
}
