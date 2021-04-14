import UIKit

class LikePopUp: UIViewController {
    
    var getString = ""
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subView.layer.cornerRadius = 12
        stateLabel.text = getString
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }

}
