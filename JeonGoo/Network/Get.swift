import Foundation

// MARK: - Post
struct Get: Codable {
    let statusCode: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case message = "message"
    }
}
