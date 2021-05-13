import Moya
import SwiftKeychainWrapper

class UserViewModel {
    fileprivate let service = UserDataService()
    
    var post: Post?
    var get: Get?
    var user: User?
    var loginData: LoginData?
    var message: String?
    
    func signInPost(email: String, pass: String, completion: @escaping ((ViewModelState) -> Void)) {
        service.signInPost(email: email, pass: pass) { (loginData, error) in
            if let error = error {
                let message = error.localizedDescription
                self.message = message
                completion(.serverError)
                return
            }
            self.loginData = loginData
           
            let statusCode = loginData!.statusCode
            if statusCode == 200 || statusCode == 201 {
                MyPageViewController.userId = loginData!.data.id
                //loginData!.data.token
                KeychainWrapper.standard.set("Bearer " + loginData!.data.token, forKey: KeychainStorage.accessToken)
                print("\(loginData!.data)")
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func signUpPost(email: String, password: String, name: String, number: String, gender: String, address: String, detailAddress: String, completion: @escaping ((ViewModelState) -> Void)) {
        service.signUpPost(email: email, password: password, name: name, number: number, gender: gender, address: address, detailAddress: detailAddress) { (post, error) in
            if let error = error {
                let message = error.localizedDescription
                self.message = message
                completion(.serverError)
                return
            }
            self.post = post
            let statusCode = post?.statusCode
            if statusCode == 200 || statusCode == 201 {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func getUserInfo(userId: Int, completion: @escaping ((ViewModelState) -> Void)) {
        service.getUserInfo(userId: userId) { (user, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.user = user
            completion(.success)
            
        }
    }
    
    func chageUserInfo(email: String, password: String, name: String, number: String, gender: String, address: String, detailAddress: String, completion: @escaping ((ViewModelState) -> Void)) {
        service.changeUserInfo(email: email, password: password, name: name, number: number, gender: gender, address: address, detailAddress: detailAddress) { (get, error) in
            if let error = error {
                let message = error.localizedDescription
                self.message = message
                completion(.serverError)
                return
            }
            self.get = get
            let statusCode = get?.statusCode
            if statusCode == 200 || statusCode == 201 {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func withdrawalUser(completion: @escaping ((ViewModelState) -> Void)) {
        service.withdrawalUser() { (get, error) in
            if let error = error {
                let message = error.localizedDescription
                self.message = message
                completion(.serverError)
                return
            }
            self.get = get
            let statusCode = get?.statusCode
            if statusCode == 200 || statusCode == 201 {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
