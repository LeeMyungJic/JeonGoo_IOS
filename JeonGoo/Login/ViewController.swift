//
//  ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Login(_ sender: Any) {
    
        let storyboard = UIStoryboard.init(name: "Pages", bundle: nil)
        
        let popUp = storyboard.instantiateViewController(identifier: "Pages")
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        present(popUp, animated: true, completion: nil)
    }
    
}

