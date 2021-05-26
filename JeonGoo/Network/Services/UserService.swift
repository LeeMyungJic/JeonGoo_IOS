import Moya
import SwiftKeychainWrapper

public enum UserService {
    case signin(email: String, password: String)
    case signup(email: String, password: String, name: String, number: String, gender: String, address: String, detailAddress: String)
    case findUser(id: Int)
    case modifyInfo(email: String, password: String, name: String, number: String, gender: String, address: String, detailAddress: String)
    case withdrawalUser
}

extension UserService: TargetType {
    
    private var token: String {
        return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
    }
    
    public var baseURL: URL {
        return URL(string: NetworkController.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .signin:
            return "/users/signin"
        case .signup:
            return "/users/signup"
        case let .findUser(userId):
            return "/users/\(userId)"
        case .modifyInfo:
            return "/users/\(MyPageViewController.userId!)"
        case .withdrawalUser:
            return "/users/\(MyPageViewController.userId!)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signin, .signup:
            return .post
        case .findUser:
            return .get
        case .modifyInfo:
            return .put
        case .withdrawalUser:
            return .delete
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .signin(email: let email, password: let password):
            return .requestCompositeParameters(bodyParameters: ["email": email, "password": password], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .signup(email: let email, password: let password, name: let name, number: let number, gender: let gender, address : let address, detailAddress : let detailAddress):
            return .requestCompositeParameters(bodyParameters: ["addressDto" : ["city" : address, "detailed" : detailAddress], "email" : email, "gender" : gender, "name" : name, "password" : password, "phoneNumber" : number], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .findUser(_):
            return .requestPlain
        case .modifyInfo(_, _, _, _, _, _, _):
            return .requestPlain
        case .withdrawalUser:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .findUser,
             .withdrawalUser:
            return ["Content-Type": "application/json",
                    "Authorization": token]
        default:
            return ["Content-Type": "application/json"]
            
        }
    }
    
    public var validationType: ValidationType {
        .successCodes
    }
}
