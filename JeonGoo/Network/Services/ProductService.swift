import Moya
import SwiftKeychainWrapper


public enum ProductService {
    case findAll
    case findById(productId: Int)
    case findByUserId
    case productRegistration(description: String, name: String, price: String, serialNumber: String, useStatus: String, images: [UIImage])
    case removeProduct
    case purchaseProduct
    case findPurchaseProductByUserId
    case findSellProductByUserId
    case findInterestedProduct
    case setInterestProduct(productId: Int)
    case setDeleteInterestProduct(productId: Int)
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
            return "/products/\(productId)/users/\(MyPageViewController.userId!)"
        case let .findByUserId:
            return "/products/users/\(MyPageViewController.userId!)"
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
        case let .findInterestedProduct:
            return "/interest/products/users/\(MyPageViewController.userId!)"
        case let .setInterestProduct(productId):
            return "/interest/products/\(productId)/users/\(MyPageViewController.userId!)"
        case let .setDeleteInterestProduct(productId):
            return "/interest/products/registered/products/\(productId)/users/\(MyPageViewController.userId!)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .findAll,
             .findById,
             .findByUserId,
             .findPurchaseProductByUserId,
             .findSellProductByUserId,
             .findInterestedProduct:
            return .get
        case .productRegistration,
             .purchaseProduct,
             .setInterestProduct:
            return .post
        case .removeProduct,
             .setDeleteInterestProduct:
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
        case .findByUserId:
            return .requestPlain
        case .productRegistration(description: let description, name: let name, price: let price, serialNumber: let serialNumber, useStatus: let useStatus, images: let images):
            var formData = [Moya.MultipartFormData]()
            for imageItem in images {
                let imageData = imageItem.jpegData(compressionQuality: 1.0)
                let memberIdData = "\(MyPageViewController.userId!)".data(using: String.Encoding.utf8) ?? Data()
                var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData!), name: "like1", fileName: "asdas.png", mimeType: "image/jpeg")]
                formData.append(Moya.MultipartFormData(provider: .data(memberIdData), name: "user_id"))
            }
            
            return .requestCompositeParameters(bodyParameters: ["fileInfoRequest": ["imageFiles" : formData], "productBasicInfoRequest":["description": description, "name": name, "price":price, "serialNumber":serialNumber, "useStatus":useStatus]], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .removeProduct:
            return .requestPlain
        case .purchaseProduct:
            return .requestCompositeParameters(bodyParameters: ["productId": DetailViewController.productId, "userId": MyPageViewController.userId!], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .findPurchaseProductByUserId:
            return .requestPlain
        case .findSellProductByUserId:
            return .requestPlain
        case .findInterestedProduct:
            return .requestPlain
        case .setInterestProduct(productId: let productId):
            return .requestCompositeParameters(bodyParameters: ["productId": productId], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .setDeleteInterestProduct:
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
