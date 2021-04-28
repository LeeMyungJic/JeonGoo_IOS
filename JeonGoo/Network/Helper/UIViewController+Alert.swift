import UIKit

extension UIViewController {
    
    func showAlertController(withTitle title: String, message: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "확인", style: .default) { action in
            completion?()
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
