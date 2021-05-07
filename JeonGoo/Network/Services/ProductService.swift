import Moya
import SwiftKeychainWrapper


public enum ProductService {
    case findAll
    case findById(productId: Int)
    case findByUserId(UserId: Int)
    case productRegistration(description: String, name: String, price: String, serialNumber: String, useStatus: String)
    case removeProduct
    case purchaseProduct
    case findPurchaseProductByUserId
    case findSellProductByUserId
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
            return "/products/\(productId)"
        case let .findByUserId(userId):
            return "/products/users/\(userId)"
        case let .productRegistration(userId):
            return "/products/users/\(MyPageViewController.userId!)"
        case let .removeProduct:
            return "/products/\(SaleListViewController.selectedId)"
        case let .purchaseProduct:
            return "/products/\(DetailViewController.productId)/purchase/\(MyPageViewController.userId!)"
        case let .findPurchaseProductByUserId:
            return "/purchased/products/users/\(MyPageViewController.userId!)/purchased"
        case let .findSellProductByUserId:
            return "/purchased/products/users/\(MyPageViewController.userId!)/sell"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .findAll,
             .findById,
             .findByUserId,
             .findPurchaseProductByUserId,
             .findSellProductByUserId:
            return .get
        case .productRegistration, .purchaseProduct:
            return .post
        case .removeProduct:
            return .delete
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
            return .requestPlain
        case .findByUserId(UserId: let userId):
            return .requestPlain
        case .productRegistration(description: let description, name: let name, price: let price, serialNumber: let serialNumber, useStatus: let useStatus):
            return .requestCompositeParameters(bodyParameters: ["fileInfoRequest": ["imageFiles" : [nil]], "productBasicInfoRequest":["description": description, "name": name, "price":price, "serialNumber":serialNumber, "useStatus":useStatus]], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .removeProduct:
            return .requestPlain
        case .purchaseProduct:
            return .requestCompositeParameters(bodyParameters: ["productId": DetailViewController.productId, "userId": MyPageViewController.userId], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .findPurchaseProductByUserId:
            return .requestPlain
        case .findSellProductByUserId:
            return .requestPlain
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
