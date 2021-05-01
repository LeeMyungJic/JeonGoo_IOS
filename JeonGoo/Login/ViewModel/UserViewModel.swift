import Moya

class UserViewModel {
    fileprivate let service = UserDataService()
    
    var post: Post?
    var message: String?
    
    func signInPost(email: String, pass: String, completion: @escaping ((ViewModelState) -> Void)) {
        service.signInPost(email: email, pass: pass) { (post, error) in
            if let error = error {
                let message = error.localizedDescription
                self.message = message
                completion(.serverError)
                return
            }
            self.post = post
           
            let statusCode = post?.statusCode
            if statusCode == 200 || statusCode == 201 {
                MyPageViewController.userId = post?.data!
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
}
