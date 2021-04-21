//
//  ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var loginBtn: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
        let id = self.idLabel.text
        let pass = self.passLabel.text
        
        if id == "" || pass == "" {
        }
        else {
            let param: [String:Any] = [
                "email": id,
                "password": pass
            ]
            
            Post(
                param: param, subURL: "/users/signin", success: {
                    self.nextVC()
                }, fail: { msg in
                })
        }
    }
    
    func nextVC() {
        let storyboard = UIStoryboard.init(name: "Pages", bundle: nil)
        
        let popUp = storyboard.instantiateViewController(identifier: "Pages")
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        self.present(popUp, animated: true, completion: nil)
    }
}

