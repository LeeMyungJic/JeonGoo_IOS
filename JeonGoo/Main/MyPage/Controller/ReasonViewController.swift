//
//  EditViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/07.
//

import UIKit

class ReasonViewController: UIViewController {

    @IBOutlet weak var reasonStr: UITextField!
    
    var getReason = "Null"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reasonStr.text = getReason

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
