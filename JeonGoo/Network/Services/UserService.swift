//
//  UserService.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/04/26.
//

import Moya
import SwiftKeychainWrapper


public enum UserService {
    case signin(email: String, password: String)
    case signup(email: String, password: String, name: String, number: String, gender: String, address: String, detailAddress: String)
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
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signin, .signup:
            return .post
            
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
