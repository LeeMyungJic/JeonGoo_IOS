//
//  ItemRegister2ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ItemRegister2ViewController: UIViewController {

    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var oldButton: UIButton!
    var new = false
    var old = false
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func newClick(_ sender: Any) {
        new = true
        old = false
        newButton.backgroundColor = #colorLiteral(red: 1, green: 0.6852490902, blue: 0.1444164813, alpha: 1)
        newButton.setTitleColor(.white, for: .disabled)
        newButton.isEnabled = false
        
        oldButton.backgroundColor = #colorLiteral(red: 0.6666144729, green: 0.6666962504, blue: 0.6665866375, alpha: 1)
        oldButton.setTitleColor(.white, for: .disabled)
        oldButton.isEnabled = true
    }
    @IBAction func oldClick(_ sender: Any) {
        new = false
        old = true
        oldButton.backgroundColor = #colorLiteral(red: 1, green: 0.6852490902, blue: 0.1444164813, alpha: 1)
        oldButton.setTitleColor(.white, for: .disabled)
        oldButton.isEnabled = false
        
        newButton.backgroundColor = #colorLiteral(red: 0.6666144729, green: 0.6666962504, blue: 0.6665866375, alpha: 1)
        newButton.setTitleColor(.white, for: .disabled)
        newButton.isEnabled = true
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
