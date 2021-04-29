import Moya

class ProductViewModel {
    fileprivate let service = ProductDataService()
    
    var ps = [P]()
    var message: String?
    
    func findAll(completion: @escaping ((ViewModelState) -> Void)) {
        service.getAllProducts() { (get, error) in
//            if let error = error {
//                let message = error.localizedDescription
//                self.message = message
//                completion(.serverError)
//                return
//            }
//            self.get = get
//            let statusCode = get?.statusCode
//            if statusCode == 200 || statusCode == 201 {
//                completion(.success)
//            }
//            else {
//                completion(.failure)
//            }
        }
    }
}
