import Moya
import SwiftKeychainWrapper


public enum ProductService {
    case findAll
    case findById(productId: Int)
}

extension ProductService: TargetType {
    
    private var token: String {
        return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
    }
    
    public var baseURL: URL {
        return URL(string: NetworkController.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .findAll:
            return "/products"
        case let .findById(productId):
            return "/products\(productId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .findAll,
             .findById:
            return .get
            
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .findAll:
            return .requestPlain
        case .findById(productId: let productId):
            return .requestCompositeParameters(bodyParameters: .init(), bodyEncoding: JSONEncoding.default, urlParameters: ["id":productId])
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "jwt": token]
        }
    }
    
    public var validationType: ValidationType {
        .successCodes
    }
}
